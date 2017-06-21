class WelcomeController < ApplicationController

  def show
    if user_login_signed_in?
      redirect_to user_root
    end
  end

end
