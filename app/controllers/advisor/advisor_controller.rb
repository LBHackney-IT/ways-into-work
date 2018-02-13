class Advisor::AdvisorController < Advisor::BaseController
  before_action :check_permissions!
  expose :advisor

  def new; end
  
  def create; end
  
  private
  
  def check_permissions!
    not_authorised unless current_advisor.admin?
  end
  
end
