class RemoveDateAchievedFromAchievements < ActiveRecord::Migration[5.1]
  def change
    remove_column :achievements, :date_achieved, :date
  end
end
