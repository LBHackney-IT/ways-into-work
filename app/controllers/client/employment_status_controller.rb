class Client::EmploymentStatusController < Client::BaseController

  def edit
  end

  def update
    if current_client.update_attributes(client_params)
      redirect_to profile_steps.next_step.url
    else
      render :edit
    end
  end

  def profile_steps
    @profile_steps ||= ProfileSteps.new(current_client, :employment)
  end
  helper_method :profile_steps


  private
  def client_params
    params.require(:client).permit(
      :employed,
      :working_hours_per_week,
      :job_title
      )
  end
end
