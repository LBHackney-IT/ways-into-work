class MeetingAgendaOption < Option
  def self.all
    [
      new('initial_assessment', 'Initial Assessment'),
      new('action_planning', 'Action Planning'),
      new('cv_writing', 'CV Writing'),
      new('interview_prep', 'Interview Prep')
    ]
  end
end
