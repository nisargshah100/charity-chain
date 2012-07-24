class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :name, :email, :password, :authentication_token
  before_create :ensure_authentication_token
  
  has_many :goals
  
  validates :name,      presence: true
  validates :email,     presence: true,
                        uniqueness: true,
                        format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :password,  presence: true

  # Creates an authentication token for a user
  # 
  # Example:
  #  user.ensure_authentication_token
  #  #=> "ippgm3uhb"
  #
  # @return [String] kind A random string token of length 9.

  def ensure_authentication_token
    self.authentication_token = rand(72**8).to_s(36)
  end
end
