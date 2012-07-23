require 'faraday'

class DonorsChoose
  def self.fetch_projects(amount=50, max=1)
    conn = Faraday.new(:url => "http://api.donorschoose.org")
    response = conn.get "/common/json_feed.html?sortBy=3&max=#{max}&costToCompleteRange=10+TO+#{amount}"
    projects = JSON.parse(response.body)['proposals']

    Project.update_all(:active => false)

    for project in projects
      p = Project.where(:external_id => project['id']).first

      if p
        p.update_attributes(:active => true)
      else
        project['title'] = HTMLEntities.new.decode(project['title'])
        Project.create(:external_id => project['id'], :external_source => 'DonorsChoose', :data => JSON.dump(project))
      end
    end
  end
end