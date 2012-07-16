class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.integer :goal_id

      t.timestamps
    end
  end
end
