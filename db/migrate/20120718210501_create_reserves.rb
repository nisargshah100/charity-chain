class CreateReserves < ActiveRecord::Migration
  def change
    create_table :reserves do |t|
      t.integer :goal_id
      t.integer :amount_cents
      t.timestamps
    end
  end
end
