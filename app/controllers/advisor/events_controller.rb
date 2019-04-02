class Advisor::EventsController < Advisor::BaseController

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to opportunities_path
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = 'Updated successfully'
      redirect_to opportunities_path
    else
      render 'edit'
    end
  end

  def event_params
    params.require(:event).permit(:title, :short_description, :closing_date, :location, :url)
  end

end