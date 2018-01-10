class OrganisationOption < Option
  def self.all
    [
      new('benefits', 'Benefits'),
      new('adult_social_care', 'Adult Social Care'),
      new('children_and_young_people', 'Children and Young People\'s Services'),
      new('adult_and_community_learning', 'HLT Adult and Community Learning'),
      new('hackney_housing', 'Tenancy and Leasehold Services (Hackney Housing)'),
      new('other', 'Other')
    ]
  end
  
  def self.display(id)
    find(id)&.name || id
  end
end
