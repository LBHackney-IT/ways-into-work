class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user_login!

  helper_method :after_sign_in_path_for

  layout 'default'

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope.user_type
    when "Advisor"
      :advisor_cases
    when "ServiceManager"
      :service_manager_cases
    else
      :clients_dashboard
    end
  end

end
