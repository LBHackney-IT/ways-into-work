class Advisor::JobsController < Advisor::BaseController

  expose :job

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to advisor_opportunities_path
    else
      render 'new'
    end
  end

  def show
  end

  def job_params
    params.require(:job).permit(:title, :short_description, :end_date, :long_description, :salary, :location, :sector, :contract)
  end

end