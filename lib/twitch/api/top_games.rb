module Twitch
  module API
    class TopGames
      def initialize(params = {})
        @params = params
        raise ArgumentError.new("Params must contain :after, :before or :first") unless params_supported?
      end

      def call
        url = Twitch::API.base_url << 'games/top'
        Query.new(url, params).call
      end

      private
      attr_reader :params

      def params_supported?
        return true if params.empty?
        (params.include?(:after) || params.include?(:before) || params.include?(:first))
      end
    end
  end
end
