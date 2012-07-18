class CheckInAddColumnDate < ActiveRecord::Migration
  def change
    add_column :check_ins, :date, :datetime
  end
end
