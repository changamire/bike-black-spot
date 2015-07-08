# BikeBlackspot app

## Snap build status
[![Build Status](https://snap-ci.com/z7lcGNV4bQa9IfbBPAH7m3nBVAcgdY7P-J9lkQQYqr8/build_image)](https://snap-ci.com/ThoughtWorksInc/bike-black-spot/branch/master)

## Getting started
- `brew update && brew doctor`
- `brew install sqlite3 transcrypt`
- `rake db:create db:migrate`

if you're a good person, and you're going to run tests:

- `brew install postgresql`
- `createuser -P -s -e go` // the test password is go
- `createdb -h localhost -p 5432 -U go app_test`
- `export RACK_ENV=test`

## Sensitive information
The file for storing sensitive information (passwords etc) is secrets.yml and is encrypted using [transcrypt](https://github.com/elasticdog/transcrypt).

Ask a member of the team for the password. 
