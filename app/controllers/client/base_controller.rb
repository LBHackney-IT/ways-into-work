class Client::BaseController < ApplicationController
  before_action :authenticate_user_login!
  before_action :authenticate_client!

  helper_method :current_client

  def current_client
    @current_client ||= current_user_login.user if current_user_login.user_type == 'Client'
  end

  def authenticate_client!
    not_authorised unless current_client.present?
  end
end
