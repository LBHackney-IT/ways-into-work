class Advisor::ActionPlanTasksController < Advisor::BaseController
  expose :client
  expose :action_plan_task

  def index; end

  def new
    action_plan_task.client_id = client.id
  end

  def edit; end

  def create
    if action_plan_task.save
      flash[:success] = "Agreed Action: #{action_plan_task.title} saved"
      redirect_to redirect_path_from_commit
    else
      render :new
    end
  end

  def update
    if action_plan_task.update(action_plan_task_params)
      flash[:success] = "Agreed Action: #{action_plan_task.title} saved"
      redirect_to advisor_client_action_plan_tasks_path(client_id: action_plan_task.client_id)
    else
      render :new
    end
  end

  def destroy
    flash[:success] = "Agreed Action: #{action_plan_task.title} deleted"
    action_plan_task.destroy!
    redirect_to advisor_client_action_plan_tasks_path(client_id: params[:client_id])
  end

  private

  def redirect_path_from_commit
    if params[:commit] == 'Save'
      advisor_client_action_plan_tasks_path(client_id: client.id)
    else
      new_advisor_client_action_plan_task_path(client_id: client.id)
    end
  end

  def action_plan_task_params
    params.require(:action_plan_task).permit(%i[
                                               title
                                               notes
                                               advisor_id
                                               client_id
                                               due_date
                                               status
                                               outcome
                                             ])
  end
end
