class Advisor::RestoreClientsController < Advisor::BaseController
  expose :client, -> { Client.find(params[:client_id]) }

  def update
    # client.restore!(recursive: true)
    client.undiscard
    redirect_to edit_advisor_client_path(client.id)
  end
end
