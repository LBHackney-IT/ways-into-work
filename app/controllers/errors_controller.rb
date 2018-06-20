class ErrorsController < ApplicationController
  
  def unauthorised
    render :unauthorised, status: 401
  end
  
  def not_found
    render :not_found, status: 404
  end
  
  def error
    render :error, status: 500
  end
end
