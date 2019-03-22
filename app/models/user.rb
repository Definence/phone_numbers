class User < ApplicationRecord
  has_secure_password
  has_secure_token :auth_token

  has_one :phone_number

  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "only allows valid emails" }

  def self.authenticate!(params)
    user = User.find_by(email: params[:email])&.authenticate(params[:password])
    user.auth_token if user
  end
end
