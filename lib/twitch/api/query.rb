module Twitch
  module API
    class Query
      def initialize(url, params)
        @url = url
        @params = params
      end

      def call
        auth_token = Twitch::API.auth_token
        response = request(auth_token)
        if response['error'].present?
          auth_token = Twitch::API.auth_token(true)
          response = request(auth_token)
        end
        response
      end

      private

      attr_accessor :url, :params

      def uri
        return @uri unless @uri.nil?

        @uri = URI(url)
        @uri.query = URI.encode_www_form(params) if params.any?
        @uri
      end

      def request(auth_token)
        # TODO: research this better to understand failures, timeouts, etc
        Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
          request = Net::HTTP::Get.new uri
          request['Authorization'] = "Bearer #{auth_token}"
          request['Client-ID'] = ENV['twitch_client_id']

          response = http.request request
          # Twitch::API.write_to_log(log_headers(response))
          ActiveSupport::JSON.decode(response.body)
        end
      rescue JSON::ParserError => e
          puts "JSON::ParserError Twitch sending bad data.  Skipping."
          puts e.message
      end

      def log_headers(response)
        "#{Time.now} : ratelimit-remaining #{sprintf('%04d', response['ratelimit-remaining'])} : ratelimit-reset-in-seconds #{response['ratelimit-reset'].to_i - Time.now.utc.to_i}"
      end

      # just getting this to work.  refactor to the token model
      def validate_auth_token(auth_token)
        uri = URL("https://id.twitch.tv/oauth2/validate")
        Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
          request = Net::HTTP::Get.new uri
          request['Authorization'] = "Oauth #{auth_token}"

          response = http.request request
        end
      end
    end
  end
end
