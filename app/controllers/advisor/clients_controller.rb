class Advisor::ClientsController < Advisor::BaseController

  expose :client, decorate: ->(client) { AdvisorClientDecorator.decorate(client) }

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
    if client.update_attributes(client_params)
      flash[:success] = I18n.t('clients.flashes.success.updated')
      redirect_back(fallback_location: root_path)
    else
      client = AdvisorClientDecorator.decorate(Client.find(params[:id]))
      init_assessment_notes
      render :edit
    end
  end

  private
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
        :other_objective,
        :other_support_priority,
        :other_type_of_work,
        :other_qualification,
        :other_training_course,
        :other_personal_trait,
        :other_gender,
        :other_bame,
        :bame,
        :studying,
        :studying_part_time,
        :receive_benefits,
        :current_education,
        :care_leaver,
        :employed,
        :has_children,
        :job_title,
        :single_parent,
        :working_hours_per_week,
        :below_living_wage,
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
