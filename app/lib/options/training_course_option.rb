class TrainingCourseOption < Option
  def self.all
    [
      new('first_aid', 'First aid'),
      new('health_and_saftey', 'Health and Safety'),
      new('cscs', 'CSCS (Construction Skills)'),
      new('sia', 'SIA (Security)'),
      new('driving_licence', 'Driving licence')
    ]
  end
end
