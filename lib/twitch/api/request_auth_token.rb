require 'net/http'

module Twitch
  module API
    class RequestAuthToken
      def call
        params = {
          client_id: ENV['twitch_client_id'],
          client_secret: ENV['twitch_client_secret'],
          grant_type: 'client_credentials'
        }
        uri = URI('https://id.twitch.tv/oauth2/token')
        uri.query = URI.encode_www_form(params)
        Net::HTTP.start(uri.host, uri.port, :use_ssl => true) do |http|
          request = Net::HTTP::Post.new uri
          response = http.request request
          ActiveSupport::JSON.decode(response.body)
        end
      rescue => e
        raise e
      end
    end
  end
end
