class AddLastFourAndCardTypeToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :last_four, :string
    add_column :payments, :card_type, :string
  end
end
