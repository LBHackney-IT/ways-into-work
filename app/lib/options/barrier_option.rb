class BarrierOption < Option
  def self.all # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    [
      new('applying_for_benefits', 'Applying for benefits'),
      new('carer', 'Carer'),
      new('childcare', 'Childcare'),
      new('criminal_record', 'Criminal record / ex-offender'),
      new('debt', 'Debt problems'),
      new('esol', 'ESOL needs'),
      new('functional_skills', 'Functional skills '),
      new('health', 'Health needs (including physical disability)'),
      new('housing', 'Housing'),
      new('no_experience', 'Lack of relevant experience'),
      new('learning_difficulty', 'Learning difficulty or disability'),
      new('confidence', 'Low confidence'),
      new('mental_health', 'Mental health issues'),
      new('overqualified', 'Overqualified'),
      new('speech_language', 'Speech and language needs'),
      new('drugs', 'Substance misuse'),
      new('where_to_begin', 'Unclear about what to do and where to begin.')
    ]
  end
end
