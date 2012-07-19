require 'hashie'

class Project < ActiveRecord::Base
  attr_accessible :external_id, :external_source, :data

  validates :external_id, :uniqueness => true, :presence => true

  def details
    Hashie::Mash.new JSON.parse(data)
  end

  has_many :donations
end
