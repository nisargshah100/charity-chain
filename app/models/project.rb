class Project < ActiveRecord::Base
  attr_accessible :city, :days_left, :description, :dollars_needed, :image_url, :project_id, :school, :state, :teacher, :title
end
