Fabricator(:achievement) do
  name { AchievementOption.all.sample(1).first }
  client { Client.last || Fabricate(:client) }
  date_achieved { Time.zone.today }
  notes { FFaker::Lorem.sentence }
end
