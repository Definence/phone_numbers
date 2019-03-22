class PhoneNumbersController < BaseController
  def create
    number = current_user.build_phone_number(number: number_params[:value])
    return render json: { number: number }, status: :created if number.save

    render json: { errors: number.errors.messages }, status: 422
  end

  def generate
    current_user.generate_phone_number
    render json: { number: current_user.phone_number }, status: :created
  end

  def number_params
    params.require(:number).permit(:value)
  end
end
