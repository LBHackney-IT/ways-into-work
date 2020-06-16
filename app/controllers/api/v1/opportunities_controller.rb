class Api::V1::OpportunitiesController < ApplicationController

    def index
        filter_type = params[:type] || 'all'
        if ["all", "jobs", "apprenticeships", "placements", "events", "training"].include?(filter_type)
          @opportunities = Opportunity.send(filter_type).active.page params[:page]
          render json: @opportunities.includes(:actable)
        end
    end

end