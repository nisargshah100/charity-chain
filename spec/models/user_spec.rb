require 'spec_helper'

describe User do
  describe ".ensure_authentication_token" do
    it "sets the authentication_token attribute" do
      user = User.new
      user.ensure_authentication_token
      user.authentication_token.size.should > 5
    end
  end
end
