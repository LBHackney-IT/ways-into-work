class Client::StepsController < Client::BaseController
  expose :client, -> { current_client.decorate }
  expose :profile_steps, -> { ProfileSteps.new(current_client, step) }

  def edit; end

  def update
    if current_client.update_attributes(client_params) && params[:commit]
      redirect_to redirect_path(params[:commit])
    else
      render :edit
    end
  end

  private

  def step_url(step)
    profile_steps.find_step(step).url
  end

  def redirect_path(step)
    {
      'Next Step' => profile_steps.next_step&.url,
      'Come back later' => :client_profile,
      'Complete Profile' => :client_next_steps
    }[step] || step_url(step)
  end
end
