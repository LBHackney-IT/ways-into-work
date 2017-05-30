class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user_login!

  helper_method :after_sign_in_path_for

  layout 'default'

  def after_sign_in_path_for(resource_or_scope)
    user_root(resource_or_scope.user_type)
  end

  def user_root(user_type = current_user_login.user_type)
    case user_type
    when "Advisor"
      :advisor_cases
    when "ServiceManager"
      :service_manager_cases
    else
      :clients_dashboard
    end
  end

end
