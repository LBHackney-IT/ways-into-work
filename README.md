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

## API

There's an API that accepts applications running at `/api/v1/applications`.

You can make a POST requests with an object of this general shape:

```
{
	"application":{
		"first_name": "Firstname",
		"last_name": "Surname",
		"email": "firstname.surname@email.com",	
        "phone_number": "07777777777",
        "statement": "About the applicant",
        "type": "CourseApplication",
		"wordpress_object_id": 100
	}
}
```

| Key           | Description                                                                         |
|---------------------|-------------------------------------------------------------------------------------|
| first_name          | String. User's first name.                                                          |
| last_name           | String. User's last name.                                                           |
| email               | String. User's email address.                                                       |
| phone_number        | String. User's phone number.                                                        |
| statement           | String containing a CV/resume/cover letter. Only for vacancy applications           |
| type                | String. Either "CourseApplication" or "VacancyApplication"                          |
| wordpress_object_id | Number. ID of the object within the opportunities WordPress site being applied for. |

### WordPress integration

The app expects to use WordPress APIs to get metadata about the thing being applied for. It does this using the `wordpress_object_id` and `type` values.

Make sure that you've supplied the domain of [the WordPress site where applications are coming from](https://github.com/LBHackney-IT/hackney-works-wp/), along with an application username and password, as environment config.

Without this, you won't be able to see what users are applying for.