class Advisor::RestoreClientsController < Advisor::BaseController

  expose :client, -> {Client.with_deleted.find(params[:client_id])}

  def update
    client.restore!
    redirect_to :advisor_clients
  end
end
