class OpportunitiesController < ApplicationController
  def index
    @opportunities = Opportunity.active
    @old_opportunities = Opportunity.inactive
  end

  def show
    @opportunity = Opportunity.find(params[:id])
  end

end