class Advisor::ActionPlanTasksController < Advisor::BaseController

  def index
    @client = Client.find(params[:client_id])
  end

  def new
    @client = Client.find(params[:client_id])
    @action_plan = @client.action_plan_tasks.build
  end

  def edit
    @client = Client.find(params[:client_id])
    @action_plan_task = ActionPlanTask.find(params[:id])
  end

  def create
    @client = Client.find(params[:client_id])
    @action_plan = @client.action_plan_tasks.build(task_params)
    if @action_plan.save
      flash[:success] = "Agreed Action: #{@action_plan.title} saved"
      redirect_to redirect_path_from_commit
    else
      render :new
    end
  end


  private

  def redirect_path_from_commit
    if params[:commit] == 'Save'
      advisor_client_action_plan_tasks_path(client_id: @client.id)
    else
      new_advisor_client_action_plan_tasks_path(client_id: @client.id)
    end
  end

  def task_params
    params.require(:action_plan_task).permit([
      :title,
      :notes,
      :advisor_id,
      :due_date,
      ])
  end

end
