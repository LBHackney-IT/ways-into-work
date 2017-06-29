class Advisor::ClientsController < Advisor::BaseController

  def show
    @client = AdvisorClientDecorator.decorate(Client.find(params[:id]))
  end

  def index
    @clients = Client.where(meetings_count: 0)
  end

  def edit
    @client = Client.find(params[:id])
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
