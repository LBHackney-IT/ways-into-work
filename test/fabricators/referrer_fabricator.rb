Fabricator(:referrer) do
  name { FFaker::Name.name }
  organisation { OrganisationOption.all[0].id }
  phone '07000 123456'
  email { FFaker::Internet.email }
  reason { FFaker::Lorem.paragraph }
end
