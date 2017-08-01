class Client::ObjectivesController < Client::BaseController

  def edit
  end

  def update
    if current_client.update_attributes(client_params)
      if params[:commit] == 'Next Step'
        redirect_to profile_steps.next_step.url   
      elsif params[:commit] == 'Come back later'    
        redirect_to :client_profile   
      end
    else
      render :edit
    end
  end

  def profile_steps
    @profile_steps ||= ProfileSteps.new(current_client, :objectives)
  end
  helper_method :profile_steps


  private
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
