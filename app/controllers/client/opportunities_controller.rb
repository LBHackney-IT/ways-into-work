class Client::OpportunitiesController < Client::BaseController
  def index
    @opportunities = Opportunity.active_ending_first
    render 'shared/opportunities/index'
  end

end