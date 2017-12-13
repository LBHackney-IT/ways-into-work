Fabricator(:referrer) do
  name { FFaker::Name.name }
  organisation { FFaker::Company.name }
  phone '07000 123456'
  email { FFaker::Internet.email }
  reason { FFaker::Lorem.paragraph }
end
