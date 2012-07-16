class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id
      t.string :name
      t.string :check_in_interval
      t.integer :wallet_amount_cents
      t.integer :reserve_amount_cents

      t.timestamps
    end
  end
end
