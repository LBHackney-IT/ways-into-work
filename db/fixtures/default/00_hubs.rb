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
    address_line_1: 'Gascoyne II Community Hall',
    address_line_2: '2 Wick Road',
    postcode: 'E9 5AY',
    longitude: -0.044574,
    latitude: 51.5447512,
    ward_mapit_codes: %w[144385 144386 144389 144395 144394 144383 144393]
  }, {
    id: 4,
    name: 'Supported Employment Hoxton Hub',
    address_line_1: '137-139 Bowling Green Walk',
    postcode: 'N1 6AL',
    longitude: -0.08319,
    latitude: 51.528154,
    ward_mapit_codes: %w[144396 144392 144382 144381 144380 144391 144379]
  }, {
    id: 5,
    name: 'Jobs Hub'
  }, {
    id: 6,
    name: 'Employment Pathways Hub'
  }
]

SeedHelper.instance.make_hubs(hubs)
