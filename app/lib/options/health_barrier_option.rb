class HealthBarrierOption < Option
  def self.all # rubocop:disable Metrics/MethodLength
    [
      new('alcohol_substance_misuse', 'Alcohol/Substance misuse issues'),
      new('anxiety', 'Anxiety'),
      new('autism', 'Autism'),
      new('depression_bipolar', 'Depression/Bipolar Disorder'),
      new('hearing', 'Hearing impairment'),
      new('learning_disability', 'Learning disability'),
      new('long_term_health', 'Physical/long-term health conditions'),
      new('personality_disorder', 'Personality Disorder'),
      new('schizophrenia', 'Schizophrenia'),
      new('visual', 'Visual impairment')
    ]
  end
end
