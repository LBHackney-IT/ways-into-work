class Client::PersonalTraitsController < Client::BaseController

  def edit
  end

  def update
    if current_client.update_attributes(client_params)
      redirect_to :edit_client_employment_status
    else
      render :edit
    end
  end

  private
  def client_params
    params.require(:client).permit(
      :other_personal_trait,
      personal_traits: []
      )
  end
end
