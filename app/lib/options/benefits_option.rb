class BenefitsOption < Option
  def self.all
    [
      new('esa', 'ESA'),
      new('ib', 'IB'),
      new('jsa', 'JSA'),
      new('uc', 'UC'),
      new('none', 'None')
    ]
  end
end
