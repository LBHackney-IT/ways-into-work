class Advisor::ExternalApprenticeshipsController < Advisor::BaseController

  def new
    @external_apprenticeship = ExternalApprenticeship.new
  end

  def create
    @external_apprenticeship = ExternalApprenticeship.new(external_apprenticeship_params)
    if @external_apprenticeship.save
      redirect_to opportunities_path
    else
      render 'new'
    end
  end

  def edit
    @external_apprenticeship = ExternalApprenticeship.find(params[:id])
  end

  def update
    @external_apprenticeship = ExternalApprenticeship.find(params[:id])
    if @external_apprenticeship.update_attributes(external_apprenticeship_params)
      redirect_to opportunity_path(@external_apprenticeship.opportunity)
    else
      render 'edit'
    end
  end

  def external_apprenticeship_params
    params.require(:external_apprenticeship).permit(:title, :short_description, :closing_date, :full_description, :pay, :location, :sector, :contract, :qualification)
  end

end
