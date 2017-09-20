# Hackney Works

This code base has been developed for a project we delivered for Hackney Council. We are currently in an alpha phase testing with one of Hackneys Hubs. This is the site's url: 

https://hackney-opportunities.herokuapp.com/

The result was based on extensive research with the Council's employees and Hackney residents. We have put some of the core Research insights on the wiki.

https://github.com/wearefuturegov/ways-into-work/wiki/Research-Insights

We hope we can develop this into the next phase with some of our more aspirational ideas.

==========

## Caveats to the code base

At the time of writing, the code base was built in a rapid first phase delivery. We had three sprints to deliver a pilot for testing with real data. Whilst we made steps to ensure it was secure enough for use with real data. See brakeman report:

```
+SUMMARY+

+-------------------+-------+
| Scanned/Reported  | Total |
+-------------------+-------+
| Controllers       | 25    |
| Models            | 10    |
| Templates         | 88    |
| Errors            | 0     |
| Security Warnings | 0 (0) |
+-------------------+-------+
```

We did take a lot of short cuts and there is a fair amount of technical debt to address in phase two.
* Code coverage is only at 75% for one.
* Although we have checked in the bullet Gem we have not used it and know the code could benefit from optimisation

# Development

## Prerequisites

* PostgreSQL
* Ruby 2.3+

## Setup

The setup process does a standard Rails setup but also creates
some Advisor/Team Leader users and some dummy client data. If you'd like to have a play:

* Clone the repo
* bundle
* You will need some basic env variable setup by copying the .env.example file -> .env
* * Add your own values to .env

```
SECRET_KEY_BASE= (use rake secret in your terminal)
DEVISE_SECRET_KEY= (use rake secret in your terminal)
DEVISE_PEPPER= (use rake secret in your terminal)
DEFAULT_PASSWORD=SomePassword
```

* cp config/database.yml.example config/database.yml
* rake db:create
* rake db:migrate
* rake db:seed # creates a test admin user and adds some schemas and documents

Try 'rails s'. Good luck!
