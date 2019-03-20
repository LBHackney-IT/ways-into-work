class Client::OpportunitiesController < Client::BaseController
  def index
    @opportunities = Opportunity.active_ending_first
    render 'advisor/opportunities/index'
  end

end