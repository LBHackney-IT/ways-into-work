class Client::BaseController < ApplicationController
  before_action :authenticate_user_login!
  before_action :authenticate_client!

  expose :current_client, lambda {
    current_user_login.user if current_user_login.user_type == 'Client'
  }

  def authenticate_client!
    not_authorised if current_client.blank?
  end
end
