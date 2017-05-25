class UserLogins::SessionsController < Devise::SessionsController
  skip_before_action :register_new_client_to_login, only: :destroy
end
