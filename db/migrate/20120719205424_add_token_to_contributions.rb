class AddTokenToContributions < ActiveRecord::Migration
  def change
    add_column :contributions, :token, :string
  end
end
