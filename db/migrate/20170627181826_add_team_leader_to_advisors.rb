class AddTeamLeaderToAdvisors < ActiveRecord::Migration[5.1]
  def change
    add_column :advisors, :team_leader, :boolean, default: false
  end
end
