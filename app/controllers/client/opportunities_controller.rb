class Client::OpportunitiesController < Client::BaseController
  def index
    @opportunities = Opportunity.all_active
  end

end