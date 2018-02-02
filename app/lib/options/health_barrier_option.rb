class HealthBarrierOption < Option
  def self.all # rubocop:disable Metrics/MethodLength
    [
      new('learning_disability', 'Learning disability'),
      new('autism', 'Autism'),
      new('depression_bipolar', 'Depression/Bipolar Disorder'),
      new('schizophrenia', 'Schizophrenia'),
      new('anxiety', 'Anxiety'),
      new('personality_disorder', 'Personality Disorder'),
      new('alcohol_substance_misuse', 'Alcohol/Substance misuse issues'),
      new('visual', 'Visual impairment'),
      new('hearing', 'Hearing impairment'),
      new('long_term_health', 'Physical/long-term health conditions')
    ]
  end
end
