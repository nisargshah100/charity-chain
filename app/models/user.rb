class User
  attr_accessor :id

  def initialize(params)
    @id = params[:id]
  end

  def self.find_by_authentication_token(token)
    User.new(:id => 1)
  end

  def goals
    [ Goal.new, Goal.new, Goal.new ]
  end

  def create_goal(params)
    params.merge({:user => self})
    Goal.create(params)
  end
end