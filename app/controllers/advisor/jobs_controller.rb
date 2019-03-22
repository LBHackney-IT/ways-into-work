class Advisor::JobsController < Advisor::BaseController

  expose :job

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to opportunities_path
    else
      render 'new'
    end
  end

  def show
  end

  def job_params
    params.require(:job).permit(:title, :short_description, :closing_date, :full_description, :pay, :location, :sector, :contract)
  end

end