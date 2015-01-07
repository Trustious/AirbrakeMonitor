AirbrakeMonitor
===============

Airbrake Monitor is a Sinatra App that reads from Airbrake API and Allows searching errors and setting some important keywords that pops up on top of your error list to give them a high priority.


Installation
===============
Make sure you have Ruby and Sinatra installed then clone the repo.

In the Repo folder, 

run "cp config.yml.example config.yml"

Edit the config.yml file, add your own Airbrake account and AuthToken, and the keywords you need for your projects.

run "bundle install", and

run "bundle exec shotgun" to bring the server up.

Open your browser, goto http://localhost:9393/

