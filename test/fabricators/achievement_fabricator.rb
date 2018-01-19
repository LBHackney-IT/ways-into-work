Fabricator(:achievement) do
  name { AchievementOption.all.sample(1).first }
  client { Client.last || Fabricate(:client) }
  date_acheived { Time.zone.today }
  notes { FFaker::Lorem.sentence }
end
