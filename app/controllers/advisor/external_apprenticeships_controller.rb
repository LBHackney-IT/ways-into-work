class Advisor::ExternalApprenticeshipsController < Advisor::BaseController

  expose :external_apprenticeship

  def new
    @external_apprenticeship = ExternalApprenticeship.new
  end

  def create
    @external_apprenticeship = ExternalApprenticeship.new(external_apprenticeship_params)
    if @external_apprenticeship.save
      redirect_to advisor_opportunities_path
    else
      render 'new'
    end
  end

  def show
  end

  def external_apprenticeship_params
    params.require(:external_apprenticeship).permit(:title, :short_description, :end_date, :long_description, :salary, :location)
  end

end