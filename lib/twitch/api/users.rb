module Twitch
  module API
    class Users
      def initialize(params = {})
        @params = params
        raise ArgumentError.new("Params must contain id or login") unless params_supported?
      end

      def call
        url = Twitch::API.base_url << 'users'
        Query.new(url, params).call
      end

      private
      attr_reader :params

      def params_supported?
        return true if params.empty?
        (params.include?(:id) || params.include?(:login))
      end
    end
  end
end
