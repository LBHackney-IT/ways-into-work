class LegalPagesController < ApplicationController

  skip_before_action :authenticate_user_login!

  def eligibility
  end

end
