Fabricator(:hub) do
  name 'The bestest hub'
  address_line_1 'A High Road'
  postcode 'E9 6AS'
  ward_mapit_codes ['00000']
  longitude '51.21323'
  latitude '-1.3455'
end

Fabricator(:homerton_hub, from: :hub) do
  name 'Homerton Library'
  address_line_1 'Homerton High Road'
  postcode 'E9 6AS'
  ward_mapit_codes %w[144395 144386 144389 144395 144394 144383 144393]
end
