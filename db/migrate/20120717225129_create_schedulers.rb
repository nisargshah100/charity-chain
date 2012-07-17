class CreateSchedulers < ActiveRecord::Migration
  def change
    create_table :schedulers do |t|
      t.integer :goal_id
      t.boolean :sunday
      t.boolean :monday
      t.boolean :tuesday
      t.boolean :wednesday
      t.boolean :thursday
      t.boolean :friday
      t.boolean :saturday
      t.timestamps
    end
  end
end
