class Advisor::AnonymiseClientsController < Advisor::BaseController
  expose :client, -> { Client.with_discarded.find(params[:client_id]) }

  def update
    client.anonymise!
    flash[:success] = I18n.t('clients.flashes.success.anonymise')
    redirect_to user_root
  end
end
