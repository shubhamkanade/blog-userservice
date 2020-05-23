class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user_params = params['user']
    user = User.find_by(email: user_params['email'], password: user_params["password"])
    if user.present?
      token = secureRandom
      render json: {user_id: user.id, user_email: user.email, auth_token: token}
    else
      render json: {message: "Invalid email or password"}, status: 404
    end
  end

  private
  def secureRandom
    SecureRandom.urlsafe_base64
  end
end