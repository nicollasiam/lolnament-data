module Operations
  class TeamUpdate

    def initialize(overrides = {})
      @team = overrides.fetch(:team) { nil }
    end

    def get_and_update_team(team_hash, league)
      @team = Team.find_or_create_by(slug: team_hash['slug'])
      @team.league = league

      @team.update(original_id: team_hash['id'],
                   name: team_hash['name'],
                   original_guid: team_hash['guid'],
                   logo_url: team_hash['logo_url'],
                   acronym: team_hash['acronym'],
                   bios: team_hash['bios'])

      @team
    end
  end
end
