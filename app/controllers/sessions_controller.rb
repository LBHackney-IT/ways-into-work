class SessionsController < Devise::SessionsController
  def new
    check_if_enquiry_signup
    super
  end
end