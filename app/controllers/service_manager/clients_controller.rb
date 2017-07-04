class ServiceManager::ClientsController < ServiceManager::BaseController

  def index
    @clients = Client.all
  end

  def show
    @client = AdvisorClientDecorator.decorate(Client.find(params[:id]))
    # We may want to isolate this per hub
    @advisors = Advisor.all
  end

end
