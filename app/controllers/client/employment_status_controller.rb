class Client::EmploymentStatusController < Client::StepsController
  private
  
  def step
    :employment
  end

  def client_params
    params.require(:client).permit(
      :employed,
      :working_hours_per_week,
      :job_title
    )
  end
end
