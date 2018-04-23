class BenefitsOption < Option
  def self.all
    [
      new('esa', 'ESA'),
      new('ib', 'IB'),
      new('jsa', 'JSA'),
      new('uc', 'UC'),
      new('is', 'IS (Income Support)'),
      new('none', 'None')
    ]
  end
end
