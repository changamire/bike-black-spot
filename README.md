# BikeBlackspot app

## Snap build status
[![Build Status](https://snap-ci.com/z7lcGNV4bQa9IfbBPAH7m3nBVAcgdY7P-J9lkQQYqr8/build_image)](https://snap-ci.com/ThoughtWorksInc/bike-black-spot/branch/master)

## Getting started
- `gem install mailcatcher`
- `mailcatcher`
- `brew update && brew doctor`
- `brew install sqlite3 transcrypt`

You will need AWS Environment keys. Ask a team member for env_vars.sh
- `chmod a+x env_vars.sh`

- `brew install postgresql`

- -----Start postgres------

- `createuser -P -s -e go` // the test password is go
- `createdb -h localhost -p 5432 -U go app_test`

- `bundle install`
- `export RACK_ENV=test`
- `rake db:init`
- `rake cb`

When opening a new terminal ALWAYS: (Setup Environment Vars)
- `./env_vars.sh`

For a clean build:
- `rake cb`

Testing:
- `rake test`
or
- `rake t`


## Sensitive information
The file for storing sensitive information (passwords etc) is secrets.yml and is encrypted using [transcrypt](https://github.com/elasticdog/transcrypt).

Ask a member of the team for the password. 
