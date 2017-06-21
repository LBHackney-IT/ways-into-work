class ServiceManager::ClientAdvisorsController < ServiceManager::BaseController

  def update
    @client = Client.find(params[:client_id])
    if @client.update_attributes(client_params)
      flash[:success] = I18n.t('clients.flashes.success.advisor_assigned')
    else
      # TODO fugly - should really render errors in the form
      flash[:error] = I18n.t('clients.flashes.error.advisor_assignment', errors: @client.errors.messages)
    end
    redirect_to service_manager_client_path(id: params[:client_id])
  end

  private

  def client_params
    params.require(:client).permit(:advisor_id)
  end
end
