module Applications
  class UpdateLeagueData

    def initialize(overrides = {})
      @rito_api = overrides.fetch(:rito_api) { ::Integrations::Rito::RitoApi.new }
    end

    def execute
      all_leagues.each do |league|
        begin
          response = JSON.parse(@rito_api.get_league(league))

          league = League.find_or_initialize_by(slug: league)

          league.update(name: response['leagues'].first['name'],
                        description: response['leagues'].first['abouts'],
                        slug: response['leagues'].first['slug'],
                        original_guid: response['leagues'].first['guid'],
                        original_id: response['leagues'].first['id'],
                        region: response['leagues'].first['region'],
                        logo_url: response['leagues'].first['logoUrl']
                        )
        rescue StandardError => error
          Rails.logger.error("Erro ao atualizar Liga #{league}: #{error}")
        end
      end
    end

    private

    def all_leagues
      ['na-lcs', 'eu-lcs', 'na-cs', 'eu-cs', 'lck', 'lpl-china', 'lms',
       'oce-opl', 'cblol-brazil']
    end
  end
end
