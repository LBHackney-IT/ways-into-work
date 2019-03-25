class Advisor::ExternalApprenticeshipsController < Advisor::BaseController

  expose :external_apprenticeship

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

  def show
  end

  def external_apprenticeship_params
    params.require(:external_apprenticeship).permit(:title, :short_description, :closing_date, :full_description, :pay, :location, :sector, :contract, :qualification)
  end

end
