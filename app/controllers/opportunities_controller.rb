class OpportunitiesController < ApplicationController
  def index
    redirect_to ENV['WORDPRESS_DOMAIN'] unless current_advisor
    filter_type = params[:type] || 'all'
    if ["all", "jobs", "apprenticeships", "placements", "events", "training"].include?(filter_type)
      @opportunities = Opportunity.send(filter_type).active.page params[:page]
      @old_opportunities = Opportunity.send(filter_type).inactive.page params[:page]
    end
  end

  def show
    redirect_to ENV['WORDPRESS_DOMAIN'] unless current_advisor
    @opportunity = Opportunity.find(params[:id])
  end

end