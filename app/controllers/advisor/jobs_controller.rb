class Advisor::JobsController < Advisor::BaseController

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

  def edit
    @job = Job.find(params[:id])
  end

  def update
    @job = Job.find(params[:id])
    if @job.update_attributes(job_params)
      redirect_to opportunity_path(@job.opportunity)
    else
      render 'edit'
    end
  end

  def job_params
    params.require(:job).permit(:title, :short_description, :closing_date, :full_description, :pay, :location, :sector, :contract, :featured)
  end

end