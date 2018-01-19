class AddRoleToAdvisors < ActiveRecord::Migration[5.1]
  def change
    add_column :advisors, :role, :integer, default: 0
    Advisor.where(team_leader: true).each { |a| a.update_column(:role, 1) } # rubocop:disable Rails/SkipsModelValidations
    remove_column :advisors, :team_leader, :boolean
  end
end
