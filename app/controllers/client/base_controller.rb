class Client::BaseController < ApplicationController

  before_action :authenticate_user_login!
  before_action :register_new_client_to_login

  helper_method :current_client

  def register_new_client_to_login
    if current_user_login && current_user_login.user_id.blank?
      redirect_to :new_client
    end
  end

  def current_client
    @current_client ||= current_user_login.user if current_user_login.user_type == 'Client'
  end

  def authentcate_client!
    not_authorised unless current_advisor.present?
  end

end
