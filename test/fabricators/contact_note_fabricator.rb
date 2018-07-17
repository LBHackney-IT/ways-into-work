Fabricator(:contact_note) do
  client { Fabricate.create(:client) }
  contact_method 'Email'
  content { FFaker::Lorem.sentence }
  advisor { Fabricate.create(:advisor) }
end
