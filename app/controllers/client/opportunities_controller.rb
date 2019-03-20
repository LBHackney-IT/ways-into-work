class Client::OpportunitiesController < Client::BaseController
  def index
    @opportunities = Opportunity.all_active
    render 'advisor/opportunities/index'
  end

end