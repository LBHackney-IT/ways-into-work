hubs = [
  {
    id: 1,
    name: 'Hoxton Hub',
    address_line_1: '137-139 Bowling Green Walk',
    address_line_2: 'Corner of Pitfield Street',
    postcode: 'N1 6AL',
    longitude: -0.08319,
    latitude: 51.528154,
    ward_mapit_codes: %w[144396 144392 144382 144381 144380 144391 144379]
  }, {
    id: 2,
    name: 'Woodberry Down Hub',
    address_line_1: 'Redmond Community Centre, Kayani Avenue',
    address_line_2: 'Woodberry Down',
    postcode: 'N4 2HF',
    longitude: -0.0917362,
    latitude: 51.5701079,
    ward_mapit_codes: %w[144398 144388 144399 144387 144397 144384 144390]
  }, {
    id: 3,
    name: 'Homerton Hub',
    address_line_1: '6a Rectory Road',
    postcode: 'N16 7QS',
    longitude: -0.0700934,
    latitude: 51.5551779,
    ward_mapit_codes: %w[144385 144386 144389 144395 144394 144383 144393]
  }, {
    id: 4,
    name: 'Supported Employment Homerton Hub',
    address_line_1: '6a Rectory Road',
    postcode: 'N16 7QS',
    longitude: -0.0700934,
    latitude: 51.5551779,
    ward_mapit_codes: %w[144385 144386 144389 144395 144394 144383 144393]
  }
]

SeedHelper.instance.make_hubs(hubs)
