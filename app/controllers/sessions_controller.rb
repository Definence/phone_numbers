class SessionsController < BaseController
  skip_before_action :authenticate_user!, only: :create

  def create
    auth_token = User.authenticate!(session_params)
    return render json: { auth_token: auth_token }, status: :created if auth_token
    render json: { errors: 'wrong data provided' }, status: 422
  end

  def destroy
    current_user.regenerate_auth_token
    head :ok
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
