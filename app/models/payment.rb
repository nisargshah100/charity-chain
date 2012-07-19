class Payment < ActiveRecord::Base
  attr_accessible :amount, :data, :contribution_id
  has_one :contribution
  
end