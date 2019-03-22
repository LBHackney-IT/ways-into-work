class Advisor::OpportunitiesController < Advisor::BaseController
  def index
    @opportunities = Opportunity.active_ending_first
    @old_opportunities = Opportunity.inactive_ending_first
    render 'shared/opportunities/index'
  end

  def new
  end

  def create
    case params[:opportunity_type]
    when "Job"
      redirect_to new_advisor_job_path
    end
  end

end
