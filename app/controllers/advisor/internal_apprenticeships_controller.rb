class Advisor::InternalApprenticeshipsController < Advisor::BaseController

  def new
    @internal_apprenticeship = InternalApprenticeship.new
  end

  def create
    @internal_apprenticeship = InternalApprenticeship.new(internal_apprenticeship_params)
    if @internal_apprenticeship.save
      redirect_to opportunities_path
    else
      render 'new'
    end
  end

  def edit
    @internal_apprenticeship = InternalApprenticeship.find(params[:id])
  end

  def update
    @internal_apprenticeship = InternalApprenticeship.find(params[:id])
    if @internal_apprenticeship.update_attributes(internal_apprenticeship_params)
      flash[:notice] = 'Updated successfully'
      redirect_to opportunities_path
    else
      render 'edit'
    end
  end

  def internal_apprenticeship_params
    params.require(:internal_apprenticeship).permit(:title, :short_description, :closing_date, :location, :url, :pay, :contract, :sector, :qualification, :featured)
  end

end