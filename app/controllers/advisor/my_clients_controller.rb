class Advisor::MyClientsController < Advisor::BaseController

  def index
    @clients_needing_appointment = current_advisor.clients.needing_appointment
    @clients_with_initial_appointment = current_advisor.clients.with_appointment
  end

end
