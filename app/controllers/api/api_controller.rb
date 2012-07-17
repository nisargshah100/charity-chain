class Api::ApiController < ActionController::Base
  private

  def current_user
    @current_user
  end

  def authenticate
    @current_user = User.find_by_authentication_token(params[:token])
  end
end