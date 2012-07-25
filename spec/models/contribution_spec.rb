require 'spec_helper'

describe Contribution do

  describe ".to_param" do
    it "returns its token" do
      Contribution.new(:token => "1").to_param.should == "1"
    end
  end

  describe ".create_contribution" do
    context "Given a goal, a payment, and parameters" do
      let(:goal) { double }
      let(:payment) { double }
      let(:params) { {:cardholder_name => "Thomas"} }

      it "should create a contribution" do
        Contribution.should_receive(:create).with({:goal => goal, :name => "Thomas", payment: payment})
        Contribution.create_contribution(goal, payment, params)
      end
    end
  end

  describe ".process" do
    let!(:goal) { double }
    let!(:payment) { double }
    let!(:params) { {:cardholder_name => "Thomas"} }

    it "processes the payment" do
      goal.stub(:id).and_return(1)
      Contribution.stub(:create_contribution)
      payment.stub(:update_attribute)
      payment.stub(:amount)
      goal.stub(:add_to_reserve_amount)

      Payment.should_receive(:process).with({:cardholder_name => "Thomas", :transaction_description => "Contribution to Goal #1 by Thomas"}).and_return(payment)
      Contribution.process(goal, params)
    end
  end
end