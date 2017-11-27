class WelcomeController < ApplicationController
  def show
    redirect_to user_root if user_login_signed_in?
  end
end
