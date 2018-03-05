module Integrations
  module Rito
    class RitoApi

      def initialize(overrides = {})
        @rito_gateway = overrides.fetch(:rito_gateway) { RitoGateway.new }
      end

      def get_league(league_slug)
        @rito_gateway.get(path: 'v1/leagues', options: "slug=#{league_slug}")
      end
    end
  end
end
