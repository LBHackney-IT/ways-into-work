class Advisor::ClientsController < Advisor::BaseController

  def show
    @client = ServiceManagerClientDecorator.decorate(Client.find(params[:id]))
    @advisors = current_advisor.hub.advisors
  end

  def index
    @clients = Client.all
  end

end
