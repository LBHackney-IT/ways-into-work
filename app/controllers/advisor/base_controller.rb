class Advisor::BaseController < ApplicationController
  before_action :authenticate_user_login!
  before_action :authenticate_current_advisor!

  def authenticate_current_advisor!
    not_authorised unless current_advisor
  end
end
