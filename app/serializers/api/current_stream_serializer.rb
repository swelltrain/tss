# frozen_string_literal: true

module Api
  class CurrentStreamSerializer
    include JSONAPI::Serializer
    attributes :display_name,
               :language,
               :started_at,
               :thumbnail_url,
               :title,
               :viewer_count

    attribute :channel do |object|
      object.streamer.login
    end

    attribute :game_name do |object|
      object.game.name
    end
  end
end
