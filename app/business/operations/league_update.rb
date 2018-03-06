module Operations
  class LeagueUpdate

    def initialize(overrides = {})
      @team_operation = overrides.fetch(:team_operation) { ::Operations::TeamUpdate.new }
      @league = overrides.fetch(:league) { nil }
    end

    def update_league(league_hash)
      @league = League.find_or_initialize_by(slug: league_hash['slug'])

      @league.update(name: response['leagues'].first['name'],
                    description: response['leagues'].first['abouts'],
                    slug: response['leagues'].first['slug'],
                    original_guid: response['leagues'].first['guid'],
                    original_id: response['leagues'].first['id'],
                    region: response['leagues'].first['region'],
                    logo_url: response['leagues'].first['logoUrl']
                    )

      remove_all_teams

      populate_teams(league_hash)
    end

    def all_leagues
      ['na-lcs', 'eu-lcs', 'na-cs', 'eu-cs', 'lck', 'lpl-china', 'lms',
       'oce-opl', 'cblol-brazil']
    end

    private

    def remove_all_teams
      @league.teams.each(&:destroy)
    end

    def populate_teams(league_hash)
      league_hash['teams'].each do |team|
        league.teams << @team_operation.get_and_update_team(team)
      end
    end
  end
end
