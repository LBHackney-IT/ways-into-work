class ApplicationController < ActionController::Base
  protect_from_forgery

  layout 'default'

  def home
    puts "Rooted to home in app ApplicationController"
  end
end
