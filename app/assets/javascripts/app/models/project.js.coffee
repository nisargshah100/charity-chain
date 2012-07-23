class App.Project extends Spine.Model
  @configure 'Project', 'id', 'proposalURL', 'imageURL', 'title', 'shortDescription', 'percentFunded', 'costToComplete', 'povertyLevel', 'schoolName', 'city', 'state'
  @extend Spine.Model.Ajax