class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer     :amount
      t.text        :data
      t.references  :contribution

      t.timestamps
    end
  end
end
