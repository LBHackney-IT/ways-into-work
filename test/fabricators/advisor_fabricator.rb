Fabricator(:advisor) do
  name { "#{FFaker::Name.first_name} #{FFaker::Name.last_name}" }
  hub { Hub.last || Fabricate(:hub) }
  login(fabricator: :user_login)
end

Fabricator(:advisor_without_hub, from: :advisor) do
  hub nil
end

Fabricator(:team_leader, from: :advisor) do
  role :team_leader
end
