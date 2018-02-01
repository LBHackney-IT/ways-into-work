class BenefitsOption < Option
  def self.all
    [
      new('jsa', 'JSA'),
      new('esa', 'ESA'),
      new('ib', 'IB'),
      new('uc', 'UC'),
      new('none', 'None')
    ]
  end
end
