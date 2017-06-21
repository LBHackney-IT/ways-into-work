class ServiceManager::ClientsController < ServiceManager::BaseController

  def index
    @unassigned_clients = Client.unassigned
    @assigned_clients = Client.assigned
  end

  def show
    @client = ServiceManagerClientDecorator.decorate(Client.find(params[:id]))
    # We may want to isolate this per hub
    @advisors = Advisor.all
  end

end
