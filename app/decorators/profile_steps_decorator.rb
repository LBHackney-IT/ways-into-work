class ProfileStepsDecorator < SimpleDelegator
  attr_reader :profile

  def initialize(profile, step)
    super step
    @profile = profile
  end

  def properties
    result = {
      'selected' => (profile.current_step?(self) ? 'true' : 'false'),
      method: 'get',
      class: decorated_class
    }
    result['disabled'] = 'disabled' unless enabled?
    result
  end

  def href
    enabled? ? url : '#'
  end

  def enabled?
    index <= [profile.latest_index, profile.current_index].max
  end

  private

  def decorated_class
    d_class = 'step button '
    d_class << 'disabled ' unless enabled?
    d_class << 'is-primary ' if profile.current_step?(self)
    d_class << 'is-white ' unless profile.current_step?(self)
    d_class << 'done ' if profile.prior_step?(self)
    d_class.strip
  end
end
