class Advisor::TrainingsController < Advisor::BaseController

  def new
    @training = Training.new
  end

  def create
    @training = Training.new(training_params)
    if @training.save
      redirect_to opportunities_path
    else
      render 'new'
    end
  end

  def edit
    @training = Training.find(params[:id])
  end

  def update
    @training = Training.find(params[:id])
    if @training.update_attributes(training_params)
      flash[:notice] = 'Updated successfully'
      redirect_to opportunities_path
    else
      render 'edit'
    end
  end

  def training_params
    params.require(:training).permit(:title, :short_description, :closing_date, :location, :url, :qualification, :featured)
  end

end