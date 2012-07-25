require 'spec_helper'

describe Payment do
  describe ".process" do
    context "Given params with a key amount" do
      let(:params) { { :amount => "10" } }
      let(:payment) { double }
      it "creates a Payment" do
        payment.stub(:id).and_return(1)
        Payment.stub(:create_queued_charge)
        Payment.should_receive(:create).with({:amount => 1000}).and_return(payment)
        Payment.process(params)
      end
    end
  end  
end
