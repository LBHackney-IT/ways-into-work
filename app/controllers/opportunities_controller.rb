class OpportunitiesController < ApplicationController
  def index
    @opportunities = Opportunity.active
    @old_opportunities = Opportunity.inactive
    render 'shared/opportunities/index'
  end

  def show
    @opportunity = Opportunity.find(params[:id])
    render 'shared/opportunities/show'
  end

end