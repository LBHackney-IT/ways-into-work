class Client::ProfilesController < Client::BaseController

  def show
    @client = current_client.decorate
  end
end
