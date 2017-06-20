class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user_login!

  helper_method :user_root

  layout 'default'

  def after_sign_in_path_for(resource_or_scope)
    user_root(resource_or_scope.user_type)
  end

  def user_root(user_type = current_user_login.user_type)
    case user_type
    when "Advisor"
      :advisor_my_clients
    when "ServiceManager"
      :service_manager_clients
    else
      :client_dashboard
    end
  end

  def not_authorised
    flash[:alert] = t('flash.errors.not_authorized')
    redirect_to request.referrer || user_root
  end

end
