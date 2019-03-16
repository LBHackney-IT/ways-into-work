class Advisor::RestoreClientsController < Advisor::BaseController
  expose :client, -> { Client.with_discarded.find(params[:client_id]) }

  def update
    client.undiscard
    redirect_to edit_advisor_client_path(client.id)
  end
end
