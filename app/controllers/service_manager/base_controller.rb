class ServiceManager::BaseController < ApplicationController

  before_action :authenticate_current_service_manager!

  helper_method :current_service_manager

  def current_service_manager
    @current_service_manager ||= current_user_login.user if current_user_login.user_type == 'ServiceManager'
  end

  def authenticate_current_service_manager!
    not_authorised unless current_service_manager
  end

end
