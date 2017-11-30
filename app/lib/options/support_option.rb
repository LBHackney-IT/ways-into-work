class SupportOption < Option
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
end
