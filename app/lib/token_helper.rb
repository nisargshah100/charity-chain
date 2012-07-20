module TokenHelper
  require 'digest/sha2'
  
  def create_token(seed="")
    sec_hash = Digest::SHA2.new << "asdf1234#{Time.now.to_i}#{seed}"
    sec_hash.to_s
  end
end