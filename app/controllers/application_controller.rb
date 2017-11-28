class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :user_root

  layout 'default'

  def after_sign_in_path_for(resource_or_scope)
    user_root(resource_or_scope.user_type)
  end

  def after_sign_out_path_for(_resource_or_scope)
    :hackney_works
  end

  def user_root(user_type = current_user_login.try(:user_type))
    case user_type
    when 'Advisor'
      :advisor_my_clients
    when 'Client'
      :client_dashboard
    else
      '/'
    end
  end

  def not_authorised
    flash[:alert] = t('flash.errors.not_authorized')
    redirect_to request.referer || user_root
  end
end
