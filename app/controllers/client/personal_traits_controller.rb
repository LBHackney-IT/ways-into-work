class Client::PersonalTraitsController < Client::StepsController
  private
  
  def step
    :about_you
  end

  def client_params
    params.require(:client).permit(
      :other_personal_trait,
      personal_traits: []
    )
  end
end
