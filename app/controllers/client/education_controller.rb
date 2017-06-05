class Client::EducationController < Client::BaseController

  def edit
  end

  def update
    if current_client.update_attributes(client_params)
      redirect_to :edit_client_objectives
    else
      render :edit
    end
  end

  def profile_steps
    @profile_steps ||= ProfileSteps.new(current_client, :education)
  end
  helper_method :profile_steps


  private
  def client_params
    params.require(:client).permit(
      :studying,
      :past_education,
      :current_education
      )
  end
end
