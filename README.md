# BikeBlackspot app

## Travis-CI build status
[![Build Status](https://travis-ci.org/changamire/bike-black-spot.svg?branch=master)](https://travis-ci.org/changamire/bike-black-spot)

## Sensitive information
The file for storing sensitive information (passwords,environment variables, etc) is secrets.yml and is encrypted using [transcrypt] - (https://github.com/elasticdog/transcrypt).

## Getting started - MAC
#Basic Install
1. Install homebrew - http://brew.sh/
2. Open terminal
3. Command: brew update
4. Command: brew doctor
5. Command: brew install postgresql
6. Command: brew install transcrypt
7. Command: gem install mailcatcher

#Setup transcrypt (ThoughtWorks team members) or use own API keys for #First time install
1. Open terminal
2. Go to project
3. Command: transcrypt
4. Command: <enter>
5. Command: n <enter>
6. Command: <cypher password here, get from team mates>
7. Command: y <enter>

#Setting up DB
1. Start postgresql
2. Open terminal
3. Command: createuser -P -s -e go
4. Command: createdb -h localhost -p 5432 -U go app_test

#Running required daemons
1. Open terminal
2. Command: mailcatcher

#First time install
1. Open terminal
2. Goto app folder
3. Command: export RACK_ENV=test
4. Run exports in secrets.yml
    - Command: export AWS_ACCESS_KEY_ID='your_secret_here'
    - Command: export AWS_SECRET_ACCESS_KEY='your_secret_here'
    - Command: export AWS_REGION='your_AWS_region_here'
    - Command: export S3_BUCKET='your_secret_here'
5. Command: bundle install
6. Command: rake cb

#Building
1. Open terminal
2. Goto app folder
3. Command: rake cb

#Running
1. Open terminal
2. Goto app folder
3. Command: rake run

#Testing
1. Open terminal
2. Goto app folder
3. Command: rake test

#Checking mailcatcher
1. Open browser
2. go to localhost:1080

#Troubleshooting
If you are using Mac OS High Sierra, and encounter this error

 +[__NSPlaceholderDictionary initialize] may have been in progress in another thread when fork() was called.
 
Read background and solution here []https://blog.phusion.nl/2017/10/13/why-ruby-app-servers-break-on-macos-high-sierra-and-what-can-be-done-about-it/ 
