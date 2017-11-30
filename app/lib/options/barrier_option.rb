class BarrierOption < Option
  def self.all
    [
      new('childcare', 'Childcare'),
      new('carer', 'Carer'),
      new('housing', 'Housing'),
      new('health', 'Health needs (including physical disability)'),
      new('mental_health', 'Mental health issues'),
      new('speech_language', 'Speech and language needs'),
      new('learning_difficulty', 'Learning difficulty or disability'),
      new('confidence', 'Low confidence'),
      new('drugs', 'Substance misuse'),
      new('criminal_record', 'Criminal record / ex-offender'),
      new('debt', 'Debt problems'),
      new('esol', 'ESOL needs'),
      new('functional_skills', 'Functional skills '),
      new('no_experience', 'Lack of relevant experience'),
      new('overqualified', 'Overqualified'),
      new('where_to_begin', 'Unclear about what to do and where to begin.')
    ]
  end
end
