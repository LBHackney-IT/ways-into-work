class ApplicationController < ActionController::Base

  before_action :store_user_location!, if: :storable_location?

  protect_from_forgery with: :exception

  helper_method :user_root

  layout 'default'

  expose :current_advisor, lambda {
    current_user_login.user if current_user_login.try(:user_type) == 'Advisor'
  }

  expose :current_client, lambda {
    current_user_login.user if current_user_login.try(:user_type) == 'Client'
  }
  
  def index
    @featured_vacancies = FeaturedVacancy.all
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || user_root(resource_or_scope)
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

  private

  def check_if_enquiry_signup
    @registering_to_enquire = true if session[:user_login_return_to]&.include? "enquiries/new"
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

end
