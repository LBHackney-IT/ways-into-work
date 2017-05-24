class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user_login!
  before_action :register_new_client_to_login

  layout 'default'

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope.user_type
    when "Advisor"
      :advisor_cases
    when "ServiceManager"
      :service_manager_cases
    else
      :new_client
    end
  end

  def register_new_client_to_login
    if current_user_login && current_user_login.user_id.blank?
      redirect_to :new_client
    end
  end
end
