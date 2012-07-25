require 'hashie'

class Project < ActiveRecord::Base
  attr_accessible :external_id, :external_source, :data, :active
  has_many :donations
  # validates :external_id, :uniqueness => true, :presence => true
  scope :all_active, :conditions => ["active = ?", true]

  def details
    Hashie::Mash.new JSON.parse(data)
  end

  def self.active
    where(:active => true)
  end

  def self.fetch(limit=1)
    active.order("RANDOM()").limit(limit)
  end
end
