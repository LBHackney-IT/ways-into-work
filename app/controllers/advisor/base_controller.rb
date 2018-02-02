class Advisor::BaseController < ApplicationController
  before_action :authenticate_user_login!
  before_action :authenticate_current_advisor!

  expose :current_advisor, lambda {
    current_user_login.user if current_user_login.user_type == 'Advisor'
  }

  def authenticate_current_advisor!
    not_authorised unless current_advisor
  end
end
