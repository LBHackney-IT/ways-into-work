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
    end
  end

  def current_footer
    if !user_login_signed_in?
      'layouts/site_footer'
    else
      'layouts/site_footer_admin'
    end
  end

  def cp(path)
    'current' if current_page?(path)
  end

  private

  def home?
    request.path == '/'
  end
end
