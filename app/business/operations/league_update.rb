module Operations
  class LeagueUpdate

    def initialize(overrides = {})
      @team_operation = overrides.fetch(:team_operation) { ::Operations::TeamUpdate.new }
    end

    def update_league(league_hash)
      league = League.find_or_initialize_by(slug: league_hash['slug'])

      league.update(name: response['leagues'].first['name'],
                    description: response['leagues'].first['abouts'],
                    slug: response['leagues'].first['slug'],
                    original_guid: response['leagues'].first['guid'],
                    original_id: response['leagues'].first['id'],
                    region: response['leagues'].first['region'],
                    logo_url: response['leagues'].first['logoUrl']
                    )
    end

    def all_leagues
      ['na-lcs', 'eu-lcs', 'na-cs', 'eu-cs', 'lck', 'lpl-china', 'lms',
       'oce-opl', 'cblol-brazil']
    end
  end
end
