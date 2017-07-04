class Advisor::MyClientsController < Advisor::BaseController

  def index
    @clients_needing_appointment = current_advisor.clients.needing_appointment
    @filterrific = initialize_filterrific(
      default_clients_with_appointment,
      params[:filterrific],
      select_options: {
        by_types_of_work: TypeOfWorkOption.options_for_select
      }
    ) or return

    @filtered_clients = @filterrific.find.page(params[:page])
  end

  def default_clients_with_appointment
    @clients_with_appointment ||= current_advisor.clients.with_appointment
  end

end
