class OpportunitiesController < ApplicationController
  def index
    @opportunities = Opportunity.active
    @old_opportunities = Opportunity.inactive
  end

  def show
    @opportunity = Opportunity.find(params[:id])
    if !current_advisor && @opportunity.closing_date < Date.today
      flash[:notice] = "Opportunity has expired"
      redirect_to opportunities_path
    end
  end

end