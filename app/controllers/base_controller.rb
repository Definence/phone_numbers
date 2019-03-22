class BaseController < ApplicationController
  before_action :authenticate_user!

  def current_user
    User.find_by(auth_token: request.headers['auth-token'])
  end

  private

  def authenticate_user!
    head 401 unless current_user
  end
end
