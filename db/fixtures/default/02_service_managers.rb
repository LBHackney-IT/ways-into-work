admins = [
  {
    email: 'jrae+admin@wearefuturegov.com',
    name: 'Jason Rae'
  },{
    email: 'chris+admin@wearefuturegov.com',
    name: 'Chris Evans'
  },{
    email: 'benunsworth+admin@wearefuturegov.com',
    name: 'Ben Unsworth'
  }
]

SeedHelper.instance.make_service_managers(admins)
