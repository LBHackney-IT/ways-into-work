class Advisor::ClientsController < Advisor::BaseController

  def show
    @client = ServiceManagerClientDecorator.decorate(Client.find(params[:id]))
  end

  def index
    @clients = Client.where(meetings_count: 0)
  end

end
