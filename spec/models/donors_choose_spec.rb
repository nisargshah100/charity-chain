require 'spec_helper'

describe DonorsChoose do
  describe ".conn" do
    it "returns a Faraday connection" do
      Faraday.should_receive(:new).with({:url => "http://api.donorschoose.org"})
      DonorsChoose.conn
    end
  end

  describe ".fetch_projects" do
    let(:proposal_mock) { double }
    before do
      DonorsChoose.stub(:get_proposals).and_return(proposal_mock)
      DonorsChoose.stub(:set_active_projects).and_return(double)
      DonorsChoose.stub(:set_inactive_projects).and_return(double)
    end
    context "when no parameters are passed in" do
      it "calls get_proposals with default values" do
        DonorsChoose.should_receive(:get_proposals).with(50, 1)
        DonorsChoose.fetch_projects
      end
      it "calls set inactive projects" do
        DonorsChoose.should_receive(:set_inactive_projects)
        DonorsChoose.fetch_projects
      end
      it "sends the response from get_proposals to set active projects" do
        DonorsChoose.should_receive(:set_active_projects).with(proposal_mock)
        DonorsChoose.fetch_projects
      end
    end
    context "when parameters are passed in" do
      it "calls get_proposals with passed in values" do
        DonorsChoose.should_receive(:get_proposals).with(17, 3)
        DonorsChoose.fetch_projects(17, 3)
      end
      it "calls set inactive projects" do

        DonorsChoose.should_receive(:set_inactive_projects)
        DonorsChoose.fetch_projects
      end
      it "sends the response from get_proposals to set active projects" do
        DonorsChoose.should_receive(:set_active_projects).with(proposal_mock)
        DonorsChoose.fetch_projects
      end
    end
  end

  describe ".get_proposals" do
    let(:conn) { double }
    let(:response) { double }

    before(:each) do
      response.stub(:body).and_return('{"proposals":""}')
      DonorsChoose.stub(:conn).and_return(conn)
    end

    it "should make a get request to DonorsChoose" do
      conn.should_receive(:get).with("/common/json_feed.html?sortBy=3&max=2&costToCompleteRange=10+TO+20").and_return(response)
      DonorsChoose.get_proposals(20, 2)
    end

    it "should parse the JSON response" do
      conn.stub(:get).and_return(response)
      DonorsChoose.get_proposals(20, 2).should == ""
    end
  end

  describe ".set_inactive_projects" do
    it "sets all projects in the database to inactive" do
      Project.should_receive(:update_all).with({:active => false})
      DonorsChoose.set_inactive_projects
    end
  end

  describe ".set_active_projects" do
    let(:projects) { [ "1", "2" ] }
    it "calls to updates project status for each project" do
      DonorsChoose.should_receive(:update_project_status).with("1")
      DonorsChoose.should_receive(:update_project_status).with("2")
      DonorsChoose.set_active_projects(projects)
    end
  end

  describe ".update_project_status" do
    let(:project) { {:id => '1'} }
    let(:found_project) { Project.new }
    context "Given the project already exists" do
      it "updates the active status to true" do
        Project.stub(:find_by_external_id).and_return(found_project)
        found_project.should_receive(:update_attribute).with(:active, true)
        DonorsChoose.update_project_status(project)
      end
    end

    context "Given the project does not exist" do
      it "updates the active status to true" do
        DonorsChoose.stub(:clean_project_title).and_return("")
        Project.should_receive(:create)
        DonorsChoose.update_project_status(project)
      end
    end

  end

  describe '.clean_project_title' do
    it 'removes escaped characters' do
      DonorsChoose.clean_project_title('this&amp;that').should == 'this&that'
    end
  end
end
