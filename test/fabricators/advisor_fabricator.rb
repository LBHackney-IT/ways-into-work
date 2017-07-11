Fabricator(:advisor) do
  name { "#{FFaker::Name.first_name} #{FFaker::Name.last_name}"}
  hub { Hub.last || Fabricate(:hub) }
  login(fabricator: :user_login)
end

Fabricator(:team_leader, from: :advisor) do
  team_leader true
end
