Fabricator(:client) do
  first_name { FFaker::Name.first_name }
  last_name { FFaker::Name.last_name }
  phone '07000 123456'
  address_line_1  'London'
  postcode 'E8 1EA'
  date_of_birth { Time.now - rand(18..35).years }
  login { Fabricate.build(:user_login) }
  advisor { Fabricate(:team_leader) }
end

Fabricator(:partial_reg_client, from: :client) do
  personal_traits { [PersonalTraitOption.all.sample.id, PersonalTraitOption.all.sample.id ].uniq  }
  objectives { [ObjectiveOption.all.sample.id, ObjectiveOption.all.sample.id ].uniq  }
  support_priorities { [SupportOption.all.sample.id, SupportOption.all.sample.id ].uniq  }
  types_of_work { [TypeOfWorkOption.all.sample.id, TypeOfWorkOption.all.sample.id ].uniq  }
end


Fabricator(:fully_reg_client, from: :partial_reg_client) do
  qualifications { [QualificationOption.all.sample.id, QualificationOption.all.sample.id ].uniq  }
  training_courses { [TrainingCourseOption.all.sample.id, TrainingCourseOption.all.sample.id ].uniq  }
  employed  true
  gender  'Male'
  receive_benefits {[true, false].sample}
end

Fabricator(:assessed_client, from: :fully_reg_client) do
  meetings { [ Fabricate.build(:meeting, advisor: Advisor.last) ] }
end
