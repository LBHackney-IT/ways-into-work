class TypeOfWorkOption
  attr_reader :id, :name

  def initialize(id, name)
    @id = id
    @name = name
  end

  def self.all
    [
      new('manual_trades', 'Manual trades'),
      new('engineering_construction', 'Engineering / construction'),
      new('retail', 'Retail'),
      new('hospitality_catering', 'Hospitality / catering'),
      new('admin', 'Admin'),
      new('childcare_youth_work', 'Childcare / youth work'),
      new('health_social_care', 'Health / social care'),
      new('cleaning', 'Cleaning'),
      new('security', 'Security'),
    ]
  end

  def self.find(id)
    all.detect{|x| x.id == id}
  end

  def self.display(ids = [])
    ids.collect{|id| find(id).name}.join(', ')
  end

  def self.options_for_select
    all.map { |e| [e.name, e.id] }
  end

end


