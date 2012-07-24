module TokenHelper
  require 'securerandom'
  
  def create_token
    SecureRandom.hex 10
  end
end