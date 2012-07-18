class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :payment_id
      t.integer :goal_id
      t.integer :amount_per_check_in_cents
      t.string :email
      t.string :name
      t.integer :user_id
      t.timestamps
    end
  end
end
