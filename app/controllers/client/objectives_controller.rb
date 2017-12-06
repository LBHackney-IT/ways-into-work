class Client::ObjectivesController < Client::StepsController
  private
  
  def step
    :objectives
  end

  def client_params
    params.require(:client).permit(
      :other_objective,
      :other_support_priority,
      :other_type_of_work,
      objectives: [],
      support_priorities: [],
      types_of_work: []
    )
  end
end
