Fabricator(:featured_vacancy) do
  position { sequence(:position) { |i| i } }
end
