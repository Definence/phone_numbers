class UsersController < ApplicationController
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
