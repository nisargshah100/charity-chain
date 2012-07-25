class Payment < ActiveRecord::Base  
  attr_accessible :amount, :data, :contribution, :last_four, :card_type
  has_one :contribution
  
  def self.process(params)
    # charge = StripeHelper.process_transaction params
    # Payment.create(amount: charge.amount.to_i, data: charge.to_json, card_type: charge.card.type, last_four: charge.card.last4)
    amount = params[:amount].to_i * 100 # TODO: THIS SHOULD BE DONE IN THE FORM AS A VALUE, NOT HERE
    payment = Payment.create(amount: amount)
    create_queued_charge(payment, params)
    payment
  end

  def self.create_queued_charge(payment, params)
    Resque.enqueue(QueuedCharge, payment.id, params)
  end
  
  def masked_number
    "XXXX-XXXX-XXXX-#{last_four}"
  end
end