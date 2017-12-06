class ProfileSteps
  # include Enumerable
  include Rails.application.routes.url_helpers

  STEPS = %i[
    about_you
    objectives
    education
    employment
  ].freeze
  
  Step = Struct.new(:index, :name, :url)

  def initialize(client, step_key)
    raise 'Invalid step key!' unless STEPS.include?(step_key)

    @client = client
    @step_key = step_key
  end

  def latest_index
    # if !@client.employed.nil?
    #   4
    # els
    if @client.qualifications.any? || @client.training_courses.any? || !@client.studying.nil?
      3
    elsif @client.objectives.any? || @client.types_of_work.any? || @client.support_priorities.any?
      2
    elsif @client.personal_traits.any?
      1
    else
      0
    end
  end

  def current_step
    step(@step_key)
  end

  def current_index
    @current_index ||= current_step.index
  end

  def next_step
    return nil if @step_key == STEPS.last

    step(STEPS[index_of_step(@step_key) + 1])
  end

  def enabled?(step)
    step.index <= [latest_index, current_index].max
  end

  def prior_step?(step)
    step.index < current_index
  end

  def current_step?(step)
    step.index == current_index
  end

  def about_you_step
    Step.new(index_of_step(:about_you), I18n.t('clients.steps.about_you.short'), edit_client_personal_traits_path)
  end

  def employment_step
    Step.new(index_of_step(:employment), I18n.t('clients.steps.employment.short'), edit_client_employment_status_path)
  end

  def objectives_step
    Step.new(index_of_step(:objectives), I18n.t('clients.steps.objectives.short'), edit_client_objectives_path)
  end
  alias goals_step objectives_step

  def education_step
    Step.new(index_of_step(:education), I18n.t('clients.steps.education.short'), edit_client_education_path)
  end

  def additional_information_step
    Step.new(index_of_step(:additional_information), I18n.t('clients.steps.additional_information.short'), edit_client_additional_information_path)
  end

  def decorated(&block)
    decorated_steps.each(&block)
    nil
  end
  
  def find_step(step_name)
    step_key = step_name.parameterize.underscore
    step(step_key)
  end

  private

  def decorated_steps
    @decorated_steps ||= STEPS.map { |key| ProfileStepsDecorator.new(self, step(key)) }
  end

  def step(key)
    __send__("#{key}_step")
  end

  def index_of_step(key)
    STEPS.index(key)
  end
end
