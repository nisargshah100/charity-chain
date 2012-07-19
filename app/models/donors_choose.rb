require 'faraday'

class DonorsChoose
  def self.fetch_projects(amount=50, max=1)
    conn = Faraday.new(:url => "http://api.donorschoose.org")
    response = conn.get "/common/json_feed.html?sortBy=3&max=#{max}&costToCompleteRange=10+TO+#{amount}"
    projects = JSON.parse(response.body)['proposals']

    for project in projects
      Project.create(:external_id => project['id'], :external_source => 'DonorsChoose', :data => JSON.dump(project))
    end
  end
end