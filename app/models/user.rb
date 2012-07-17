class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :email, :password
end
