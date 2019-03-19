class Advisor::JobsController < Advisor::BaseController

  expose :job

  def new
    @job = Job.new
  end

  def create
    @job = Job.create(job_params)
    redirect_to advisor_opportunities_path
  end

  def job_params
    params.require(:job).permit(:title, :short_description, :end_date, :long_description, :salary)
  end

end