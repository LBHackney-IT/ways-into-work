class Client::BaseController < ApplicationController
  before_action :authenticate_user_login!
  before_action :authenticate_client!

  def authenticate_client!
    not_authorised if current_client.blank?
  end
end
