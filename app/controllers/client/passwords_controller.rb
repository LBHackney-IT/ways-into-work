class Client::PasswordsController < ApplicationController
  before_action :assert_reset_token_passed, only: :edit

  def edit
    @user_login = UserLogin.find(params[:user_login_id])
    @minimum_password_length = UserLogin.password_length.min
    @user_login.reset_password_token = params[:reset_password_token]
  end

  # Check if a reset_password_token is provided in the request
  def assert_reset_token_passed
    return if params[:reset_password_token].present?
    set_flash_message(:alert, :no_token)
    redirect_to new_user_login_session_path
  end
end
