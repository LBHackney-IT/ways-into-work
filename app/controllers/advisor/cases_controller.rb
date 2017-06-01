class Advisor::CasesController < Advisor::BaseController

  def index
    @clients = Client.all
  end

end
