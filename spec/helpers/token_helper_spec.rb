require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ChainsHelper. For example:
#
# describe ChainsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe TokenHelper do
  describe "create_token" do
    it "creates a token that is a string of length 8" do
      helper.create_token.length.should == 8
    end
  end
end
