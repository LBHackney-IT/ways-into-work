class AcheivementOption < Option
  def self.all # rubocop:disable Metrics/MethodLength
    [
      new('cv_completed', 'CV completed'),
      new('job_application', 'Job application submitted'),
      new('interview', 'Interview attended'),
      new('placement_volunteering', 'Work placement or volunteering (would need a start and finish date)'),
      new('training_started', 'Training (start and finish date)'),
      new('course_completed', 'Complete education course for e.g. college courses or degree'),
      new('job_start', 'Job/apprenticeship start'),
      new('job_sustained', 'Sustained job (>6 months)'),
      new('boc_completed', 'BOCs completed'),
      new('13_week_sustainment', '13 week sustainment')
    ]
  end
end
