class Advisor::ActionPlanTasksController < Advisor::BaseController
  expose :client, decorate: ->(client) { AdvisorClientDecorator.decorate(client) }
  expose :action_plan_task

  def index
    if params[:print_view]
      render :print_view
    else
      render :index
    end
  end

  def new
    action_plan_task.client_id = client.id
  end

  def edit; end

  def create
    if action_plan_task.save
      flash[:success] = I18n.t('flash.success.task_saved', title: action_plan_task.title)
      redirect_to redirect_path_from_commit
    else
      render :new
    end
  end

  def update
    if action_plan_task.update(action_plan_task_params)
      flash[:success] = I18n.t('flash.success.task_saved', title: action_plan_task.title)
      redirect_to advisor_client_action_plan_tasks_path(client_id: action_plan_task.client_id)
    else
      render :new
    end
  end

  def destroy
    flash[:success] = I18n.t('flash.success.task_deleted', title: action_plan_task.title)
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
      achievement_name
    ])
  end
end
