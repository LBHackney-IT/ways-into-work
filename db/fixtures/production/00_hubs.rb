hubs = [
  {
    id: 1,
    name: 'Hoxton Opportunity Hub',
    address_line_1: '137-139 Bowling Green Walk',
    address_line_2: 'Corner of Pitfield Street',
    postcode: 'N1 6AL',
    longitude: -0.08319,
    latitude: 51.528154,
    ward_mapit_codes: ['144396', '144392', '144382', '144381', '144380', '144391', '144379' ]
  },{
    id: 2,
    name: 'Redmond Community Centre',
    address_line_1: 'Kayani Avenue',
    address_line_2: 'Woodberry Down',
    postcode: 'N4 2HF',
    longitude: -0.0936387,
    latitude: 51.570132,
    ward_mapit_codes: ['144398', '144388', '144399', '144387', '144397', '144384', '144390']
  },{
    id: 3,
    name: 'Homerton Library',
    address_line_1: 'Homerton High Road',
    postcode: 'E9 6AS',
    longitude: -0.0438469,
    latitude: 51.5488747,
    ward_mapit_codes: ['144385', '144386', '144389', '144395', '144394', '144383', '144393' ]
  }
]

SeedHelper.instance.make_hubs(hubs)
