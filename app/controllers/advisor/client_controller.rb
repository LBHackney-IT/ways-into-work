class Advisor::ClientController < Advisor::BaseController

  def show
    @client = Client.find(params[:id])
  end
end
