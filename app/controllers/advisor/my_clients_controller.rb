class Advisor::MyClientsController < Advisor::BaseController
  def index
    @clients_requiring_contact = current_advisor.clients.needing_contact.sort_by {|obj| obj.created_at }.reverse
    init_filtered_clients
    respond_to do |format|
      format.html
      format.js
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
      by_age: [['Under 25', :under_25s]]
    }
  end
end
