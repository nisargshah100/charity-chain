class Api::ApiController < ApplicationController
  private

  def authenticate
    # current_user ||= User.find_by_authentication_token(params[:token])
  end
end