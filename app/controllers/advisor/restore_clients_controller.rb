class Advisor::RestoreClientsController < Advisor::BaseController
  expose :client, -> { Client.with_deleted.find(params[:client_id]) }

  def update
    client.restore!(recursive: true)
    redirect_to edit_advisor_client_path(client.id)
  end
end
