Fabricator(:action_plan_task) do
  title { FFaker::Job.title }
  due_date { Time.zone.now.utc + 7.days }
  client { Client.last || Fabricate(:client) }
end
