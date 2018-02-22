class Advisor::AnonymiseClientsController < Advisor::BaseController
  expose :client, -> { Client.with_deleted.find(params[:client_id]) }

  def update
    client.anonymise!
    flash[:success] = I18n.t('clients.flashes.success.anonymise')
    redirect_to advisor_my_clients_path
  end
end
