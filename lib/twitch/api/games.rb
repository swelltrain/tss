module Twitch
  module API
    class Games
      def initialize(params = {})
        @params = params
        raise ArgumentError.new("Params must contain id or name") unless params_supported?
      end

      def call
        url = Twitch::API.base_url << 'games'
        Query.new(url, params).call
      end

      private
      attr_reader :params

      def params_supported?
        return true if params.empty?
        (params.include?(:id) || params.include?(:name))
      end
    end
  end
end
