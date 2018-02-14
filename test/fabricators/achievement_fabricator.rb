Fabricator(:achievement) do
  name { AchievementOption.all.sample(1).first }
  client { Client.last || Fabricate(:client) }
  notes { FFaker::Lorem.sentence }
end
