# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :verify_signed_out_user
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = warden.authenticate!(auth_options)
    token = Tiddle.create_and_return_token(user, request)
    render json: { authentication_token: token }
  end

  # DELETE /resource/sign_out
  def destroy
    if current_user && Tiddle.expire_token(current_user, request)
      head :ok
    else
      # Client tried to expire an invalid token
      render json: { error: 'invalid token' }, status: 401
    end
  end
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  private

  # this is invoked before destroy and we have to override it
  def verify_signed_out_user; end

  def post_params
    params.permit(:id, :email, :password)
  end
end
