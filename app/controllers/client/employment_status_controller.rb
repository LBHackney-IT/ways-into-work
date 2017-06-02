class Client::EmploymentStatusController < Client::BaseController

  def edit
  end

  def update
    if current_client.update_attributes(client_params)
      redirect_to :edit_client_aspirations
    else
      render :edit
    end
  end

  private
  def client_params
    params.require(:client).permit(
      :employed,
      :working_hours_per_week,
      :time_since_last_job,
      :job_title
      )
  end
end
