class AddTokenToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :token, :string
  end
end
