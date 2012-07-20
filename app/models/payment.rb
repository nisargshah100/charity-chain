class Payment < ActiveRecord::Base  
  attr_accessible :amount, :data, :contribution, :last_four, :card_type
  has_one :contribution
  
  def self.process params
    charge = StripeHelper.process_transaction params
    Payment.create(amount: charge.amount.to_i, data: charge.to_json, card_type: charge.card.type, last_four: charge.card.last4)
  end
  
  def masked_number
    "XXXX-XXXX-XXXX-#{last_four}"
  end
end