class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout 'default'

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope.user_type
    when "Advisor"
      :advisor_cases
    else
      :new_client
    end
  end
end
