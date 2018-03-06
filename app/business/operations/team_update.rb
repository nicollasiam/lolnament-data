module Operations
  class TeamUpdate

    def initialize(overrides = {})
      @team = overrides.fetch(:team) { nil }
    end

    def get_and_update_team(team_hash)

    end
  end
end
