Fabricator(:client) do
  first_name { FFaker::Name.first_name }
  last_name { FFaker::Name.last_name }
  phone '07000 123456'
  address_line_1  'London'
  postcode 'E8 1EA'
  date_of_birth { Time.now - 30.years }
  login { Fabricate.build(:user_login) }
end
