class Advisor::BaseController < ApplicationController

  before_action :authenticate_current_advisor!

  helper_method :current_advisor

  def current_advisor
    @current_advisor ||= current_user_login.user if current_user_login.user_type == 'Advisor'
  end

  def authenticate_current_advisor!
    not_authorised unless current_advisor
  end

end
