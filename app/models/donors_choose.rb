require 'faraday'

class DonorsChoose
  def self.conn
    Faraday.new(:url => "http://api.donorschoose.org")
  end

  def self.fetch_projects(amount=50, max=1)
    get_proposals(amount, max)
    set_inactive_projects
    set_active_projects(projects)
  end

  def self.get_proposals(amount, max)
    response = conn.get "/common/json_feed.html?sortBy=3&max=#{max}&costToCompleteRange=10+TO+#{amount}"
    projects = JSON.parse(response.body)['proposals']
  end

  def self.set_inactive_projects
    Project.update_all(:active => false)
  end

  def self.set_active_projects(projects)
    for project in projects
      update_project_status(project)
    end
  end

  def self.update_project_status(project)
    if p = Project.find_by_external_id(project['id'])
      p.update_attribute(:active, true)
    else
      project['title'] = clean_project_title(project['title'])
      Project.create(:external_id => project['id'], :external_source => 'DonorsChoose', :data => JSON.dump(project))
    end
  end

  def self.clean_project_title(title)
    HTMLEntities.new.decode(title)
  end
end