advisors = [
  {
    email: 'kiran@wearefuturegov.com',
    name: 'Kiran Dhillon',
    hub_id: 2
  }, {
    email: 'kiran+tl@wearefuturegov.com',
    name: 'Kiran Team Leader',
    team_leader: true,
    hub_id: 1
  }, {
    email: 'chris@wearefuturegov.com',
    name: 'Chris Evans',
    hub_id: 1
  }, {
    email: 'chris+tl@wearefuturegov.com',
    name: 'Chris Team Leader',
    team_leader: true,
    hub_id: 2
  }, {
    email: 'benunsworth@wearefuturegov.com',
    name: 'Ben Unsworth',
    hub_id: 3
  }, {
    email: 'elle@wearefuturegov.com',
    name: 'Elle Tweedy',
    hub_id: 1
  }, {
    email: 'jan@wearefuturegov.com',
    name: 'Jan Blum',
    hub_id: 2
  }, {
    email: 'kevin@wearefuturegov.com',
    name: 'Kevin Lewis',
    hub_id: 2
  }, {
    email: 'jan+tl@wearefuturegov.com',
    name: 'Jan Team Leader',
    team_leader: true,
    hub_id: 3
  },
  {
    email: 'jrae@wearefuturegov.com',
    name: 'Jason Rae',
    hub_id: 2
  }
]

SeedHelper.instance.make_advisors(advisors)
