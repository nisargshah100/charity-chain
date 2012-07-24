module TokenHelper
  require 'securerandom'
  
  def create_token
    SecureRandom.hex 4
  end
end