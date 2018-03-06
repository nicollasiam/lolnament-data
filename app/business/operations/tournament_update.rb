module Operations
  class TournamentUpdate

    def initialize(overrides = {})
      @tournament = overrides.fetch(:tounament) { nil }
    end

    def get_and_update_tournament(tournament_hash, league)
      @tournament = Tournament.find_or_initialize_by(original_guid: tournament_hash['id'])
      @tournament.league = league

      @tournament.update(original_guid: tournament_hash['id'],
                         title: tournament_hash['title'],
                         description: tournament_hash['description']
                        )

      @tournament
    end
  end
end
