class Advisor::UnassignedClientsController < Advisor::BaseController

  def index
    @clients = Client.all
  end

end
