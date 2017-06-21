class Advisor::UnassignedClientsController < Advisor::BaseController

  def index
    @clients = Client.unassigned
  end

end
