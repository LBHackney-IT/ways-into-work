class Client::ProfilesController < Client::BaseController
  expose :client, -> {current_client.decorate}

  def show
  end
end
