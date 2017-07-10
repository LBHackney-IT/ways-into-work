class Advisor::MyClientsController < Advisor::BaseController

  def index
    @clients_needing_appointment = current_advisor.clients.needing_appointment.to_a
    init_filtered_clients
  end

  private

    def init_filtered_clients
      @filterrific = initialize_filterrific(
        current_advisor.clients.with_appointment,
        params[:filterrific],
        select_options: {
          by_types_of_work: TypeOfWorkOption.options_for_select
        }
      ) or return
      @filtered_clients = @filterrific.find.page(params[:page])
    end

end
