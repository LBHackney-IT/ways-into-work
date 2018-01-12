class Advisor::AcheivementsController < Advisor::BaseController
  expose :client
  expose :acheivement, build_params: -> { { client: client }.merge(achievement_params) }
  expose :acheivements, -> { client.acheivements }
  
  def index; end
  
  def create
    acheivement.save
    redirect_to advisor_client_acheivements_url(client)
  end
  
  protected
  
  def achievement_params
    params.require(:acheivement).permit(
      :name,
      :date_acheived,
      :notes
    )
  end
  
end
