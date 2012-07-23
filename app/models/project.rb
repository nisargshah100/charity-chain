require 'hashie'

class Project < ActiveRecord::Base
  attr_accessible :external_id, :external_source, :data, :active

  # validates :external_id, :uniqueness => true, :presence => true

  def details
    Hashie::Mash.new JSON.parse(data)
  end

  def self.active
    where(:active => true)
  end

  has_many :donations
end
