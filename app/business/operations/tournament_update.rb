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
                         description: tournament_hash['description'],
                         start_date: tournament_hash['startDate'],
                         end_date: tournament_hash['endDate']
                        )

      # Remove all teams and repopulate
      remove_all_teams
      populate_rosters(tournament_hash)

      # Create the tournament standings
      populate_standings(tournament_hash)

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

    def populate_standings(tournament_hash)
      return nil unless tournament_hash['standings']
      position = 0

      tournament_hash['standings']['result'].each do |stand|
        stand.each do |roster_hash|
          position += 1

          team_original_id = tournament_hash['rosters'].find { |k, v| k == roster_hash['roster'] }[1]['team']
          team = Team.find_by(original_id: team_original_id)
          new_stand = Standing.create(tournament: @tournament,
                                       team: team,
                                       position: position
                                      )

          @tournament.standings << new_stand
          team.standings << new_stand
        end
      end
    end
  end
end
