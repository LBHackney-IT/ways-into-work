class EqualitiesOption < Option
  def self.all # rubocop:disable Metrics/MethodLength
    [
      new('workless_on_benefits', 'People out of work on benefits'),
      new('workless_off_benefits', 'People not on benefits and not in work'),
      new('welfare_reform', 'People affected by welfare reform'),
      new('under_25', 'Under 25 years old'),
      new('over_50', 'Over 50 years old'),
      new('care_leavers', 'Care leavers'),
      new('health_conditions', 'People with health conditions'),
      new('female', 'Women'),
      new('bame', 'BAME')
    ]
  end
end
