module ApplicationHelper

  def current_header
    if !user_login_signed_in?
      'layouts/site_header_base'
    elsif current_user_login.user_id.blank?
      'layouts/site_header_client_registration'
    elsif current_user_login.user_type == 'Client'
      'layouts/site_header_client'
    elsif current_user_login.user_type == 'Advisor'
      'layouts/site_header_advisor'
    else
      'layouts/site_header_service_manager'
    end
  end

  def cp(path)
    "current" if current_page?(path)
  end
end
