class Client::ObjectivesController < Client::BaseController

  def edit
  end

  def update
    if current_client.update_attributes(client_params)
      redirect_to :client_profile
    else
      render :edit
    end
  end

  private
  def client_params
    params.require(:client).permit(
      :other_objectives,
      objectivess: []
      )
  end
end
