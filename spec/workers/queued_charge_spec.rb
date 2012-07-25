require 'spec_helper'

describe "queued charge" do
  let!(:payment)      { Payment.create }
  let!(:params)       { { stuff: "blah" } }
  let!(:charge_data)  { Hashie::Mash.new( id: 7,
                                          paid: true,
                                          card:{ type: "Visa", last4: "4334" }) }

  before(:each) do
    Stripe::Charge.stub(:create).and_return(charge_data)
  end

  it "processes a pending charge & returns the updated payment record" do
    QueuedCharge.perform(payment.id, params)
    payment.reload
    payment.card_type.should == charge_data.card.type
    payment.last_four.should == charge_data.card.last4
  end
end