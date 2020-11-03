class OpportunitiesController < ApplicationController
  def index
    redirect_to ENV['WORDPRESS_DOMAIN'] unless current_advisor
  end

  def show
    redirect_to ENV['WORDPRESS_DOMAIN'] unless current_advisor
    @opportunity = Opportunity.find(params[:id])
  end

end