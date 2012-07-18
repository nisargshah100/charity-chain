class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :email, :password, :authentication_token
  has_many :goals
  before_create :ensure_authentication_token
  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
  validates :password, presence: true

  def ensure_authentication_token
    self.authentication_token = rand(72**8).to_s(36)
  end
end