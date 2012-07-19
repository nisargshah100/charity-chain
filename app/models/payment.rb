class Payment < ActiveRecord::Base
  attr_accessible :amount, :data, :contribution_id, :last_four, :card_type
  has_one :contribution
  
end