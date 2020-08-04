module Twitch
  module API
    class Streams
      def initialize(params = {})
        @params = params
        raise ArgumentError unless params_supported?
      end

      def call
        url = Twitch::API.base_url << 'streams'
        Query.new(url, params).call
      end

      private
      attr_reader :params

      def params_supported?
        return true if params.empty?
        (params.include?(:after) || params.include?(:before) || params.include?(:first) || params.include?(:game_id) || params.include?(:user_id) || params.include?(:user_login))
      end
    end
  end
end
