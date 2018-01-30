class BameOption < Option
  def self.all
    [
      new('asian', 'Asian or Asian British'),
      new('black', 'Black British / African / Caribbean'),
      new('mixed', 'Mixed'),
      new('white_british', 'White British'),
      new('white', 'White Other'),
      new('private', 'Prefer not to say')
    ]
  end
end
