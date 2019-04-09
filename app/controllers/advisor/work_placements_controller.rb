class Advisor::WorkPlacementsController < Advisor::BaseController

  def new
    @work_placement = WorkPlacement.new
  end

  def create
    @work_placement = WorkPlacement.new(work_placement_params)
    if @work_placement.save
      redirect_to opportunities_path
    else
      render 'new'
    end
  end

  def edit
    @work_placement = WorkPlacement.find(params[:id])
  end

  def update
    @work_placement = WorkPlacement.find(params[:id])
    if @work_placement.update_attributes(work_placement_params)
      redirect_to opportunity_path(@work_placement.opportunity)
    else
      render 'edit'
    end
  end

  def work_placement_params
    params.require(:work_placement).permit(:title, :short_description, :closing_date, :full_description, :pay, :location, :sector, :contract, :featured)
  end

end