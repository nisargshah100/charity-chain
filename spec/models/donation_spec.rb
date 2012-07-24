require 'spec_helper'

describe Donation do
  let!(:donation) { Donation.new(amount: 20) }
  let!(:goal) { double }
  
  describe "#ensure_less_than_wallet" do
    before { goal.stub(:wallet_amount).and_return(Money.new(1000)) }

    it "adds an error if the donation amount is greater than the wallet amount" do
      donation.stub(:goal).and_return(goal)
      donation.ensure_less_than_wallet
      donation.errors.full_messages.first.should == "Amount must be less than wallet ($10.00)"
    end
  end

  describe "#ensure_less_than_reserve" do
    before { goal.stub(:reserve_amount).and_return(Money.new(1000)) }
    it "adds an error if the donation amount is greater than the reserve amount" do
      donation.stub(:goal).and_return(goal)
      donation.ensure_less_than_reserve
      donation.errors.full_messages.first.should == "Amount must be less than reserve ($10.00)"
    end
  end

  describe "#reduce_wallet_amount" do
    let!(:wallet) { double }
    before { goal.stub(:wallet_amount).and_return(Money.new(2000)) }

    it "updates the wallet amount reducing it by the donation amount" do
      donation.stub(:goal).and_return(goal)
      donation.stub(:wallet).and_return(wallet)
      wallet.should_receive(:update_attribute).with(:amount, Money.new(0))
      donation.send(:reduce_wallet_amount)
    end
  end

  describe "#reduce_reserve_amount" do
    let!(:reserve) { double }
    before { goal.stub(:reserve_amount).and_return(Money.new(2000)) }

    it "updates the reserve amount reducing it by the donation amount" do
      donation.stub(:goal).and_return(goal)
      donation.stub(:reserve).and_return(reserve)
      reserve.should_receive(:update_attribute).with(:amount, Money.new(0))
      donation.send(:reduce_reserve_amount)
    end
  end
end
