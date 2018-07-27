[![Build Status](http://img.shields.io/circleci/project/github/wearefuturegov/ways-into-work.svg?style=flat-square)](https://circleci.com/gh/wearefuturegov/ways-into-work)
[![Coverage Status](http://img.shields.io/coveralls/wearefuturegov/ways-into-work.svg?style=flat-square)](https://coveralls.io/r/wearefuturegov/ways-into-work)
[![License](http://img.shields.io/:license-apache-blue.svg?style=flat-square)](http://www.apache.org/licenses/LICENSE-2.0.html)

# Hackney Works

Hackney Works is a free service that provides coaching and advice to Hackney
residents who are looking for work.

This digital tool allows residents to sign up for the service, and enhances the
face to face service offered by advisors, letting them see information about the
client, book appointments, send reminders and mark key goals and achievements.

# Development

## Prerequisites

* PostgreSQL
* Ruby 2.3+

## Setup

The setup process does a standard Rails setup but also creates
some Advisor/Team Leader users and some dummy client data. If you'd like to have a play:

### Clone the repo

```
git clone https://github.com/wearefuturegov/ways-into-work.git
cd ways-into-work
```

### Install dependencies

```
bundle install
```

### Setup environment variables

```
cp .env.example .env
```

Then add the relevant environment variables to the resulting .env file

### Setup database

```
cp config/database.yml.example config/database.yml
bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:seed # creates a test admin user and adds some schemas and documents
```

### Run server

```
bundle exec rails s
```

The server is now running at http://localhost:3000
