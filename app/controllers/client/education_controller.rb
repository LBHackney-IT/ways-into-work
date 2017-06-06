class Client::EducationController < Client::BaseController

  def edit
  end

  def update
    if current_client.update_attributes(client_params)
      if params[:commit] == 'Next Step'
        redirect_to :client_profile
      elsif params[:commit] == 'Save and Exit'
        redirect_to :client_profile
      end
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
      :studying_part_time,
      :past_education,
      :current_education
      )
  end
end
