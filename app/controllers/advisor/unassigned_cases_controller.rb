class Advisor::UnassignedCasesController < Advisor::BaseController

  def index
    @clients = Client.all
  end

end
