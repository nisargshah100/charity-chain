class GoalsRemoveColumnsWalletAndReserve < ActiveRecord::Migration
  def change
    remove_column :goals, :wallet_amount_cents
    remove_column :goals, :reserve_amount_cents
    change_column :wallets, :amount_cents, :integer, :default => 0
    change_column :reserves, :amount_cents, :integer, :default => 0
  end
end
