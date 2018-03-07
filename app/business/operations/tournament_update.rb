module Operations
  class TournamentUpdate

    def initialize(overrides = {})
      @tournament = overrides.fetch(:tournament) { nil }
    end

    def get_and_update_tournament(tournament_hash, league)
      @tournament = Tournament.find_or_initialize_by(original_guid: tournament_hash['id'])
      @tournament.league = league

      @tournament.update(original_guid: tournament_hash['id'],
                         title: tournament_hash['title'],
                         description: tournament_hash['description']
                        )

      # Remove all teams
      remove_all_teams
      populate_rosters(tournament_hash)

      @tournament
    end

    private

    def remove_all_teams
      @tournament.rosters.each(&:delete)
    end

    def populate_rosters(tournament_hash)
      tournament_hash['rosters'].each do |team_key, team_value|
        # It is odd but team_value['team'] is the team's id
        team = Team.find_by(original_id: team_value['team'])
        Roster.create(tournament: @tournament, team: team)
      end
    end
  end
end
