module Operations
  class LeagueUpdate

    def initialize(overrides = {})
      @team_operation = overrides.fetch(:team_operation) { ::Operations::TeamUpdate.new }
      @tournament_operation = overrides.fetch(:tournament_operation) { ::Operations::TournamentUpdate.new }
      @league = overrides.fetch(:league) { nil }
    end

    def update_league(league_hash)
      @league = League.find_or_create_by(slug: league_hash['leagues'].first['slug'])

      @league.update(name: league_hash['leagues'].first['name'],
                    description: league_hash['leagues'].first['abouts'],
                    slug: league_hash['leagues'].first['slug'],
                    original_guid: league_hash['leagues'].first['guid'],
                    original_id: league_hash['leagues'].first['id'],
                    region: league_hash['leagues'].first['region'],
                    logo_url: league_hash['leagues'].first['logoUrl']
                    )

      update_teams(league_hash)

      # The is no need to remove all tournaments before
      # becouse a tournament will always be of that league
      # (unlike players)
      update_tournaments(league_hash)

    end

    def all_leagues
      ['na-lcs', 'eu-lcs', 'na-cs', 'eu-cs', 'lck', 'lpl-china', 'lms',
       'oce-opl', 'cblol-brazil']
    end

    private

    def update_teams(league_hash)
      league_hash['teams'].each do |team|
        @team_operation.update_team(team, @league)
      end
    end

    def update_tournaments(league_hash)
      league_hash['highlanderTournaments'].each do |tournament|
        @league.tournaments << @tournament_operation.get_and_update_tournament(tournament, @league)
      end
    end
  end
end
