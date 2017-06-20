class EligibilityController < ApplicationController

  skip_before_action :authenticate_user_login!

  def outside_hackney
  end
end
