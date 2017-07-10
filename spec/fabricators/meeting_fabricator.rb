Fabricator(:meeting) do
  start_datetime { Time.now + 1.hour }
end
