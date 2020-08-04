module Twitch
  module Downloaders
    class Streamers
      def call
        while true
          cursor = get_batches(cursor)
          if cursor.nil?
            puts "Cursor is nil so we are done with this set of batches."
            break
          end
        end
      end

      private

      def get_batches(cursor)
        stream_values = Twitch::API::Streams.new(first: 100, after: cursor).call
        if stream_values['data'].nil?
          puts "Stream Value data is blank.  Trying again: #{stream_values}"
          stream_values = Twitch::API::Streams.new(first: 100, after: cursor).call # docs say try again :/
          return nil if stream_values['data'].nil?
        end

        user_ids = stream_values['data'].reduce([]) { |memo, values|
          memo << values.fetch('user_id') }
        return nil if user_ids.blank?
        game_ids = stream_values['data'].reduce([]) { |memo, values|
          memo << values.fetch('game_id') }
        cursor = stream_values['pagination']['cursor']

        user_values = Twitch::API::Users.new(id: user_ids).call
        if user_values['data'].blank?
          puts "Bad Data: User Values are blank.  Stream Values: #{stream_values}"
        end
        game_values = Twitch::API::Games.new(id: game_ids).call
        if game_values['data'].blank?
          puts "Bad Data: Game Values are blank.  Stream Values: #{stream_values}"
        end
        begin
          ActiveRecord::Base.transaction do
            persist_to_db(stream_values, user_values, game_values)
          end
        rescue ActiveRecord::RecordNotUnique => e
          puts "stupid twitch has non unique"
        end
        sleep(0.125)
        cursor
      end

      def persist_to_db(stream_values, user_values, game_values)
        return unless user_values['data'].present?
        user_values['data'].each do |values|
          s = Streamer.where(original_provider_id: values.fetch('id')).first_or_initialize do |streamer|
            streamer.login = values.fetch('login')
            streamer.original_provider = 'Twitch'
            streamer.display_name = values.fetch('display_name')
            streamer.view_count = values.fetch('view_count')
            streamer.providers_type = values.fetch('type')
            streamer.broadcaster_type = values.fetch('broadcaster_type')
            streamer.description = values.fetch('description')
            streamer.profile_image_url = values.fetch('profile_image_url')
            streamer.offline_image_url = values.fetch('offline_image_url')
          end
          s.update_source_queried_at!
          s.up_times.create!(up_time_at: Time.now)
        end
        game_values['data'].each do |values|
          Game.where(original_provider_id: values.fetch('id')).first_or_create! do |game|
            game.provider = 'Twitch'
            game.name = values.fetch('name')
            game.box_art_url = values.fetch('box_art_url')
          end
        end
        stream_values['data'].each do |stream_value|
          game = Game.where(original_provider_id: stream_value.fetch('game_id').to_i).first
          # there are some streamers who are streaming with game id set to 0
          # idk what the hell they are streaming
          next if game.nil?
          streamer = Streamer.where(original_provider_id: stream_value.fetch('user_id').to_i).first
          if streamer.nil?
            puts "Bad data: no streamer in db found for user id: [#{stream_value.fetch('user_id').to_i}]"
            next
          end
          viewer_count = stream_value.fetch('viewer_count')
          title = stream_value.fetch('title')
          begin
            current_stream = CurrentStream.where(display_name: streamer.display_name).first_or_create! do |cs|
              cs.streamer_id= streamer.id
              cs.game_id= game.id
              cs.streamers_original_provider_id = stream_value.fetch('user_id')
              cs.title = title
              cs.viewer_count = viewer_count
              cs.started_at = stream_value.fetch('started_at')
              cs.thumbnail_url = stream_value.fetch('thumbnail_url')
              cs.language = stream_value.fetch('language')
            end
            current_stream.update_attributes!(updated_at: Time.now)
          rescue ActiveRecord::RecordNotUnique => e
            puts "CURRENT STREAMERROR: #{e.message}"
          end
        end
      end
    end
  end
end
