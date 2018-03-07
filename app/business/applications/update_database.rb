module Applications
  class UpdateDatabase

    def initialize(overrides = {})
      @rito_api = overrides.fetch(:rito_api) { ::Integrations::Rito::RitoApi.new }
      @league_operarion = overrides.fetch(:league_operarion) { ::Operations::LeagueUpdate.new }
    end

    def execute
      start_time = Time.now

      @league_operarion.all_leagues.each do |league|
        begin
          response = JSON.parse(@rito_api.get_league(league))

          @league_operarion.update_league(response)
        rescue StandardError => error
          Rails.logger.error("Erro ao atualizar Liga #{league}: #{error}")
        end
      end

      end_time = Time.now
      minutes = (end_time - start_time) / 60
      seconds = (end_time - start_time) % 60
      Rails.logger.info("Time elapsed #{minutes.to_i}:#{seconds.round(2)}")
    end
  end
end
