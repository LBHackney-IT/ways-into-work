class ContactMethodOption < Option
  def self.all
    [
      new('Email'),
      new('Phone call'),
      # new('Hub visit')
    ]
  end
end
