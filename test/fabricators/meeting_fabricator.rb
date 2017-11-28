Fabricator(:meeting) do
  start_datetime { Time.zone.now + 1.hour }
end
