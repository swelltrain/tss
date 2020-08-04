
module Twitch
  Error = Class.new(StandardError)
  module API
    class << self
      attr_accessor :client_id

      def configure
        yield self
      end

      def base_url
        'https://api.twitch.tv/helix/'
      end

      def auth_token(refresh=false)
        if refresh
          @auth_token = nil
          @auth_expires = nil
        end
        return @auth_token unless @auth_token.nil?

        results = Twitch::API::RequestAuthToken.new.call
        @auth_token = results['access_token']
        @auth_expires = Time.now + results['expires_in'].to_i.seconds
        @auth_token
      end

      def revoke_access_token
        return if @auth_token.nil?
        puts "revoking access token! #{@auth_token}"
        params = {client_id: ENV['twitch_client_id'], token: @auth_token}
        uri = URI('https://id.twitch.tv/oauth2/revoke')
        uri.query = URI.encode_www_form(params)
        Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
          request = Net::HTTP::Post.new uri
          http.request request
        end
      end

      def write_to_log(slug)
        #currently used by query
        @log_file ||= File.open(Rails.root.join('log/twitch_api_logging'),'a')
        @log_file.sync = true
        @log_file.puts slug
      end

      def close_log_file
        @log_file.close unless @log_file.nil?
      end
    end
  end
end
