class Advisor::ClientsController < Advisor::BaseController

  def show
    @client = ServiceManagerClientDecorator.decorate(Client.find(params[:id]))
  end

  def index
    @clients = Client.all
  end

  def assign_to_me
    client = Client.find(params[:client_id])
    client.advisor = current_advisor
    client.save(validate: false)
    redirect_to advisor_client_path(client)
  end
end
