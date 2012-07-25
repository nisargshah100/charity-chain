require 'spec_helper'

describe Payment do
  let(:params) { { :amount => "10" } }
  let(:payment) { double }

  describe ".process" do
    context "Given params with a key amount" do
      it "creates a Payment" do
        Payment.stub(:create_queued_charge)
        Payment.should_receive(:create).with({:amount => 1000}).and_return(payment)
        Payment.process(params)
      end

      it "creates a queued charge" do
        Payment.stub(:create).and_return(payment)
        Payment.should_receive(:create_queued_charge).with(payment, params)
        Payment.process(params)
      end
    end
  end  

  describe ".create_queued_charge" do
    it "enqueues a job in Resque" do
      payment.stub(:id).and_return(1)
      Resque.should_receive(:enqueue).with(QueuedCharge, 1, params)
      Payment.create_queued_charge(payment, params)
    end
  end

  describe "#masked_number" do
    it "returns a masked number" do
      payment = Payment.new(:last_four => "1234")
      payment.masked_number.should == "XXXX-XXXX-XXXX-1234"
    end
  end
end
