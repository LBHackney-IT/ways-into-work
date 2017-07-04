class Advisor::ClientsController < Advisor::BaseController

  def index
    @filterrific = initialize_filterrific(
      Client,
      params[:filterrific],
      select_options: {
        by_hub_id: Hub.options_for_select,
        by_advisor_id: Advisor.options_for_select(selected_hub_id),
        by_types_of_work: TypeOfWorkOption.options_for_select
      },
      default_filter_params: {
        by_hub_id: default_hub_id
      }
    ) or return
    @clients = @filterrific.find.page(params[:page])

    # @clients = Client.needing_appointment
  end

  def edit
    @client = AdvisorClientDecorator.decorate(Client.find(params[:id]))
    init_assessment_notes
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(client_params)
      redirect_to :advisor_my_clients
    else
      # init_assessment_notes
      render :edit
    end
  end

  private

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
        :studying,
        :studying_part_time,
        :receive_benefits,
        :current_education,
        :care_leaver,
        :employed,
        :has_children,
        :job_title,
        :lone_parent,
        :working_hours_per_week,
        :below_living_wage,
        :gender,
        :rag_status,
        qualifications: [],
        objectives: [],
        support_priorities: [],
        types_of_work: [],
        other_personal_trait: [],
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
          @client.assessment_notes.find_or_initialize_by(content_key: key)
          )
      end
    end

    def assessment_note_keys
      [
        'aspirations',
        'strengths',
        'not_good_at',
        'driving_force',
        'job_goal_1',
        'job_goal_2',
        'barriers',
        'general'
      ]
    end

end
