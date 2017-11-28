class SupportOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('new_skills', 'Learning new skills'),
      new('re_training', 'Re trainining'),
      new('find_a_job_quick', 'Finding a job quickly'),
      new('start_career', 'Getting my career started'),
      new('confidence', 'Increasing my confidence'),
      new('more_qualifications', 'Getting more qualifications'),
      new('employability', 'Interview / CV help')
    ]
  end

  def self.find(id)
    all.detect { |x| x.id == id }
  end

  def self.display(ids = [])
    ids.collect { |id| find(id).name }.join(', ')
  end
end
