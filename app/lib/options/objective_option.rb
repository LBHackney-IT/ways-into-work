class ObjectiveOption < Option
  def self.all
    [
      new('full_time_work', 'Full time work'),
      new('part_time_work', 'Part time work'),
      new('training_qualification', 'Training or qualifications'),
      new('apprenticeship', 'Apprenticeship'),
      new('work_experience', 'Work experience')
    ]
  end
end
