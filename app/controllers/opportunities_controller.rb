class OpportunitiesController < ApplicationController
  def index
    filter_type = params[:type] || 'all'
    @opportunities = Opportunity.send(filter_type).active
    @old_opportunities = Opportunity.send(filter_type).inactive
  end

  def show
    @opportunity = Opportunity.find(params[:id])
    if !current_advisor && @opportunity.closing_date < Date.today
      flash[:notice] = "Opportunity has expired"
      redirect_to opportunities_path
    end
  end

end