module Applications
  class UpdateDatabase

    def initialize(overrides = {})
      @rito_api = overrides.fetch(:rito_api) { ::Integrations::Rito::RitoApi.new }
      @league_operarion = overrides.fetch(:league_operarion) { ::Operations::LeagueUpdate.new }
    end

    def execute
      @league_operarion.all_leagues.each do |league|
        begin
          response = JSON.parse(@rito_api.get_league(league))

          @league_operarion.update_league(response)
        rescue StandardError => error
          Rails.logger.error("Erro ao atualizar Liga #{league}: #{error}")
        end
      end
    end
  end
end
