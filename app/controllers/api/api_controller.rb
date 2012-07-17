class Api::ApiController < ActionController::Base
  private

  def current_user
    @current_user
  end

  def authenticate
    @current_user = User.find_by_authentication_token(params[:token])
    render :json => false, :status => 403 if not @current_user
  end
end