class Advisor::MyClientsController < Advisor::BaseController
  def index
    @clients_requiring_contact = current_advisor.clients.needing_contact.to_a
    init_filtered_clients
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data Client.csv(@filterrific.find), type: 'text/csv', disposition: 'attachment; filename=clients.csv' }
    end
  end

  private

  def init_filtered_clients
    (@filterrific = initialize_filterrific(
      current_advisor.clients.with_appointment,
      params[:filterrific],
      persistence_id: false,
      select_options: filterrific_options
    )) || return
    @filtered_clients = @filterrific.find.page(params[:page])
  end

  def filterrific_options
    {
      by_types_of_work: TypeOfWorkOption.options_for_select,
      by_training: TrainingCourseOption.options_for_select,
      by_age: [['Under 25', :under_25s]],
      archived: [['Archived', :archived], ['All', :all]]
    }
  end
end
