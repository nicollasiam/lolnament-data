module Operations
  class TeamUpdate

    def initialize(overrides = {})
      @team = overrides.fetch(:team) { nil }
    end

    def get_and_update_team(team_hash)
      @team = find_or_create_by(slug: team_hash['slug'])

      @team.update(original_id: team_hash['id'],
                   name: team_hash['name'])
    end
  end
end
