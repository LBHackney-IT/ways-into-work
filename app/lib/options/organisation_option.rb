class OrganisationOption < Option
  def self.all # rubocop:disable Metrics/MethodLength
    [
      new('adult_social_care', 'Adult Social Care'),
      new('benefits', 'Benefits'),
      new('children_and_young_people', 'Children and Young People\'s Services'),
      new('job_centre_finsbury', 'Job Centre Plus - Finsbury Park'),
      new('job_centre_mare', 'Job Centre Plus - Mare Street'),
      new('job_centre_hoxton', 'Job Centre Plus - Hoxton'),
      new('city_mind', 'Hackney and City Mind'),
      new('adult_and_community_learning', 'HLT Adult and Community Learning'),
      new('manor_house', 'Manor House Development Trust'),
      new('hackney_housing', 'Tenancy and Leasehold Services (Hackney Housing)'),
      new('other', 'Other')
    ]
  end

  def self.display(id)
    find(id)&.name || id
  end
end
