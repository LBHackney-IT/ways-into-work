class WelcomeController < ApplicationController

  skip_before_action :authenticate_user_login!

  def show
    if user_login_signed_in?
      redirect_to user_root
    end
  end

end
