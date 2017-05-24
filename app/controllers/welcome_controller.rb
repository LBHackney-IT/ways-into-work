class WelcomeController < ApplicationController

  skip_before_action :authenticate_user_login!

  def show
  end

end
