class Advisor::ClientsController < Advisor::BaseController # rubocop:disable ClassLength
  expose :client, decorate: ->(client) { AdvisorClientDecorator.decorate(client) }
  expose :referrer, -> { ReferrerDecorator.decorate(client.referrer) }
  before_action :init_client, only: :create

  def new
    client.build_login
  end

  def create
    if client.save && client.generate_initial_meeting
      flash[:success] = "#{client.name} saved."
      redirect_to edit_advisor_client_path(client)
    else
      render :new
    end
  end

  def index
    init_filterrific_table
    respond_to do |format|
      format.html
      format.js
      format.csv { send_data Client.csv(@filterrific.find), type: 'text/csv', disposition: 'attachment; filename=clients.csv' }
    end
  end

  def edit
    init_assessment_notes
  end

  def update
    if params[:commit] == 'Assign Advisor' ? assign_advisor : update_client
      redirect_back(fallback_location: @fallback_location)
    else
      AdvisorClientDecorator.decorate(Client.find(params[:id]))
      init_assessment_notes
      render :edit
    end
  end

  def destroy
    client.destroy
    flash[:success] = I18n.t('clients.flashes.success.archived')
    redirect_to advisor_my_clients_path
  end

  private

  def assign_advisor
    if client.assign_advisor(params[:client][:advisor_id], current_advisor)
      flash[:success] = I18n.t('clients.flashes.success.advisor_assigned')
    else
      flash[:error] = I18n.t('clients.flashes.error.advisor_assignment')
    end
    @fallback_location = edit_advisor_client_path(client)
  end

  def update_client
    if client.update_attributes(edit_client_params)
      client.update_advisor(current_advisor, current_advisor) if params[:commit] == 'Assign to me'
      flash[:success] = I18n.t('clients.flashes.success.updated')
      @fallback_location = root_path
      true
    else
      false
    end
  end

  def init_client
    if HackneyWardFinder.new(client_params[:postcode]).in_hackney?
      client.advisor = current_advisor
      client.login.generate_default_password
    else
      redirect_to :outside_hackney
    end
  end

  def init_filterrific_table
    (@filterrific = initialize_filterrific(
      Client,
      params[:filterrific],
      persistence_id: false,
      select_options: filterrific_options,
      default_filter_params: {
        by_hub_id: default_hub_id
      }
    )) || return
    @filtered_clients = @filterrific.find.page(params[:page])
  end
  
  def filterrific_options
    {
      by_hub_id: Hub.options_for_select,
      by_advisor_id: Advisor.options_for_select(selected_hub_id),
      by_types_of_work: TypeOfWorkOption.options_for_select,
      by_training: TrainingCourseOption.options_for_select,
      by_age: [['Under 25', true]]
    }
  end

  def default_hub_id
    @default_hub_id ||= current_advisor.default_hub_id
  end

  def selected_hub_id
    return default_hub_id if params[:filterrific].blank?
    params[:filterrific][:by_hub_id]
  end

  def client_params # rubocop:disable Metrics/MethodLength
    params.require(:client).permit(
      :title,
      :first_name,
      :last_name,
      :phone,
      :preferred_contact_method,
      :address_line_1,
      :address_line_2,
      :postcode,
      login_attributes: [:email]
    )
  end

  def edit_client_params # rubocop:disable Metrics/MethodLength
    params.require(:client).permit(
      :other_objective,
      :other_support_priority,
      :other_type_of_work,
      :other_qualification,
      :other_training_course,
      :other_personal_trait,
      :other_gender,
      :other_bame,
      :national_insurance_number,
      :affected_by_benefit_cap,
      :assigned_supported_employment,
      :date_of_birth,
      :bame,
      :studying,
      :studying_part_time,
      :receive_benefits,
      :current_education,
      :care_leaver,
      :employed,
      :job_title,
      :working_hours_per_week,
      :health_conditions,
      :affected_by_welfare,
      :gender,
      :rag_status,
      :first_name,
      :last_name,
      :email,
      :phone,
      :address_line_1,
      :address_line_2,
      :postcode,
      funded: [],
      qualifications: [],
      barriers: [],
      objectives: [],
      support_priorities: [],
      types_of_work: [],
      training_courses: [],
      personal_traits: [],
      assessment_notes_attributes: %i[
        id
        content
        content_key
      ]
    )
  end

  def init_assessment_notes
    assessment_note_keys.each do |key|
      instance_variable_set(
        "@#{key}_notes",
        client.assessment_notes.find_or_initialize_by(content_key: key)
      )
    end
  end

  def assessment_note_keys # rubocop:disable Metrics/MethodLength
    %w[
      aspirations
      strengths
      not_good_at
      driving_force
      past_education
      work_experience
      job_goal_1
      job_goal_2
      barriers
      general
      support
      get_better_at
    ]
  end
end
