class Advisor::ClientsController < Advisor::BaseController

  expose :client, decorate: ->(client) { AdvisorClientDecorator.decorate(client) }
  before_action :init_client, only: :create

  def new
    client.build_login
  end

  def create
    if client.save
      flash[:success] = "#{client.name} saved."
      # client.login.send_reset_password_instructions if client.login
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
    end
  end

  def edit
    init_assessment_notes
  end

  def update
    if client.update_attributes(edit_client_params)
      flash[:success] = I18n.t('clients.flashes.success.updated')
      redirect_back(fallback_location: root_path)
    else
      client = AdvisorClientDecorator.decorate(Client.find(params[:id]))
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
    def init_client
      if ward_mapit_code = HackneyWardFinder.new(client_params[:postcode]).lookup
        client.assign_team_leader(ward_mapit_code)
        client.login.generate_default_password
      else
        redirect_to :outside_hackney
      end
    end

    def init_filterrific_table
      @filterrific = initialize_filterrific(
        Client,
        params[:filterrific],
        persistence_id: false,
        select_options: {
          by_hub_id: Hub.options_for_select,
          by_advisor_id: Advisor.options_for_select(selected_hub_id),
          by_types_of_work: TypeOfWorkOption.options_for_select,
          by_training: TrainingCourseOption.options_for_select,
          by_age: [['Under 25', true] ]
        },
        default_filter_params: {
          by_hub_id: default_hub_id
        }
      ) or return
      @filtered_clients = @filterrific.find.page(params[:page])
    end

    def default_hub_id
      @default_hub_id ||= current_advisor.hub_id
    end

    def selected_hub_id
      return default_hub_id if params[:filterrific].blank?
      params[:filterrific][:by_hub_id]
    end

    def client_params
      params.require(:client).permit(
        :title,
        :first_name,
        :last_name,
        :phone,
        :preferred_contact_method,
        :address_line_1,
        :address_line_2,
        :postcode,
        login_attributes: [ :email ]
        )
    end

    def edit_client_params
      params.require(:client).permit(
        :other_objective,
        :other_support_priority,
        :other_type_of_work,
        :other_qualification,
        :other_training_course,
        :other_personal_trait,
        :other_gender,
        :other_bame,
        :date_of_birth,
        :advisor_id,
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
        :funded,
        :gender,
        :rag_status,
        qualifications: [],
        barriers: [],
        objectives: [],
        support_priorities: [],
        types_of_work: [],
        training_courses: [],
        personal_traits: [],
        assessment_notes_attributes: [
          :id,
          :content,
          :content_key,
          ]
        )
    end

    def init_assessment_notes
      assessment_note_keys.each do |key|
        self.instance_variable_set(
          "@#{key}_notes",
          client.assessment_notes.find_or_initialize_by(content_key: key)
          )
      end
    end

    def assessment_note_keys
      [
        'aspirations',
        'strengths',
        'not_good_at',
        'driving_force',
        'past_education',
        'work_experience',
        'job_goal_1',
        'job_goal_2',
        'barriers',
        'general',
        'support',
        'get_better_at'
      ]
    end

end
