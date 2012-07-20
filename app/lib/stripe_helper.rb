module StripeHelper
  def self.process_transaction params
    charge = Stripe::Charge.create(
      :amount => (params[:amount].to_i * 100), # convert dollars passed in from form to cents
      :currency => "usd",
      :card => params[:stripe_token],
      :description => params[:transaction_description]
    )
    if successful_charge?(charge)
      charge
    else
      raise "Payment failed.  Please contact support."
    end
  end

  def self.successful_charge?(charge)
    charge && charge.id && charge.paid
    # keys = [:id, :amount, :created, :currency, :description, :disputed, :fee, :livemode, :object, :paid, :refunded, :card, :fee_details]
    # <Stripe::Charge:0x3ff25b8955c0 id=ch_KIGAVFpmYxyuVC> JSON: {"id":"ch_KIGAVFpmYxyuVC","amount":1000,"created":1342733269,"currency":"usd","description":"Contribution to Goal #29 by ","disputed":false,"fee":59,"livemode":false,"object":"charge","paid":true,"refunded":false,"card":{"address_city":null,"country":"US","cvc_check":"pass","exp_month":1,"exp_year":2016,"fingerprint":"EWN0c9r9Gfc63cJw","last4":"4242","object":"card","type":"Visa"},"fee_details":[{"type":"stripe_fee","currency":"usd","description":"Stripe processing fees","amount":59,"application":null}]}
  end
end