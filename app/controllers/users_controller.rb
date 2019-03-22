class UsersController < BaseController
  skip_before_action :authenticate_user!

  def create
    user = User.new(user_params)
    return render json: { user: user }, status: :created if user.save

    render json: { errors: user.errors.messages }, status: 422
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
