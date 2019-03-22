class SessionsController < BaseController
  skip_before_action :authenticate_user!

  def create
    auth_token = User.authenticate!(session_params)
    return render json: { auth_token: auth_token }, status: :created if auth_token
    render json: { errors: 'wrong data provided' }, status: 422
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
