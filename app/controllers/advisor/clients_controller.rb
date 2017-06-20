class Advisor::ClientsController < Advisor::BaseController

  def show
    @client = Client.find(params[:id])
  end

  def index
    @clients = Client.all
  end
end
