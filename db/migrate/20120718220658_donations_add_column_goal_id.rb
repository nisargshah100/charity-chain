class DonationsAddColumnGoalId < ActiveRecord::Migration
  def change
    add_column :donations, :goal_id, :integer
    remove_column :donations, :user_id, :integer
  end
end
