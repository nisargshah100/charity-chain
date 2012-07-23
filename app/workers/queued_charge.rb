class QueuedCharge
  @queue = :charges
  def self.perform(payment_id, params)
    charge = StripeHelper.process_transaction(params)
    payment = Payment.find(payment_id)
    payment.update_attributes(data: charge.to_json,
        card_type: charge.card.type,
        last_four: charge.card.last4)
  end
end