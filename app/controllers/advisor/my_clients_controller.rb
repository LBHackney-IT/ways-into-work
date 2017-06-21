class Advisor::MyClientsController < Advisor::BaseController

  def index
    @clients = current_advisor.clients
  end

end
