class QualificationOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('btec', 'BTEC'),
      new('nvq_level2', 'NVQ Level 2'),
      new('nvq_level3', 'NVQ Level 3'),
      new('nvq_level4', 'NVQ Level 4'),
      new('gcses_o_levels', 'GCSEs / O Levels'),
      new('english_skills', 'Functional skills English'),
      new('maths_skills', 'Functional skills Maths'),
      new('a_levels', 'A Levels'),
      new('degree', 'Degree'),
      new('persuasive', 'ESOL qualifications')
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

  def self.display(ids = [])
    ids.collect{|id| find(id).name}.join(', ')
  end

end


