class ProfileStepsDecorator < SimpleDelegator
  attr_reader :profile_step

  def initialize(profile, step)
    super step
    @profile_step = profile
  end

  def properties
    result = {
      'selected' => (profile_step.current_step?(self) ? 'true' : 'false'),
      class: decorated_class
    }
    result['disabled'] = 'disabled' unless profile_step.enabled?(self)
    result
  end

  private

  def decorated_class
    d_class = 'step button '
    d_class << 'disabled ' unless profile_step.enabled?(self)
    d_class << 'is-primary ' if profile_step.current_step?(self)
    d_class << 'is-white ' unless profile_step.current_step?(self)
    d_class << 'done ' if profile_step.prior_step?(self)
    d_class.strip
  end
end
