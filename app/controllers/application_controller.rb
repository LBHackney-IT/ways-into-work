class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :user_root

  layout 'default'

  expose :current_advisor, lambda {
    current_user_login.user if current_user_login.user_type == 'Advisor'
  }

  expose :current_client, lambda {
    current_user_login.user if current_user_login.user_type == 'Client'
  }

  def after_sign_in_path_for(resource_or_scope)
    user_root(resource_or_scope)
  end

  def after_sign_out_path_for(_resource_or_scope)
    :hackney_works
  end

  def user_root(login = current_user_login)
    login&.root_page || '/'
  end

  def not_authorised
    flash[:alert] = t('flash.errors.not_authorized')
    redirect_to request.referer || user_root
  end
end
