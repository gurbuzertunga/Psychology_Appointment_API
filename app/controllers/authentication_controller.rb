class AuthenticationController < ApplicationController
  skip_before_action :authorize_request, only: :create
  # return auth token once user is authenticated
  def create
    user = AuthenticateUser.new(auth_params[:email], auth_params[:password])
    doctor = user.instance_variable_get(:@doctor)
    auth_token = user.call
    json_response(auth_token: auth_token, doctor: doctor)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end