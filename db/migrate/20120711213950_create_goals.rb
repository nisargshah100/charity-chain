class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.string :days
      t.integer :amount_cents
      t.string :time_period

      t.timestamps
    end
  end
end
