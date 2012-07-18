class Project < ActiveRecord::Base
  attr_accessible :external_id, :external_source, :data

  has_many :donations
end
