Fabricator(:advisor) do
  first_name { FFaker::Name.first_name }
  last_name { FFaker::Name.last_name}
  login(fabricator: :user_login)
end
