class OutcomeOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('cv', "Complete CV"),
      new('interview', "Attend interview"),
      new('work_volunteering_experience', "Work experience / volunteering"),
      new('job_application', "Job application"),
      new('training', "Complete training"),
      new('job_apprenticeship', "Aquire job / apprenticeship"),
      new('sustain_job', "Sustain job (> 6 months)")
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

end


