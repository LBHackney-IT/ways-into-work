class MeetingAgendaOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('initial_assessment', 'Initial Assessment'),
      new('action_planning', 'Action Planning'),
      new('cv_writing', 'CV Writing'),
      new('interview_prep', 'Interview Prep')
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

  def self.display(ids = [])
    ids.collect{|id| find(id).name}.join(', ')
  end

end


