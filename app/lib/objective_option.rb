class ObjectiveOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('full_time_work', 'Full time work'),
      new('part_time_work', 'Part time work'),
      new('training_qualification', 'Training or qualifications'),
      new('apprenticeship', 'Apprenticeship'),
      new('work_experience', 'Work experience')
    ]
  end

  def self.find(id)
    all.detect { |x| x.id == id }
  end

  def self.display(ids = [])
    ids.collect { |id| find(id).name }.join(', ')
  end
end
