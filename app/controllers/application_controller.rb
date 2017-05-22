class ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'default'

  def home
    puts "Rooted to home in app ApplicationController"
  end

  def after_sign_in_path_for(resource_or_scope)
    case resource_or_scope.user_type
    when "Advisor"
      :advisor_cases
    else
      "/"
    end
  end
end
