# OAuth Sample

## Setup

Uses [https://github.com/octopi/octopis-sinatra-on-heroku](https://github.com/octopi/octopis-sinatra-on-heroku) as a base.

This setup includes support for erb views and MongoDB. `mongod` must be running on port 27017 by default. Locally, the sample code connects to the `test` database with a `testCollection` and a `users` collection.

After you create a new Heroku app, a MongoLab account needs to be linked and the appropriate collections need to be set up.

## What's Included
The code here is meant to OAuth through to the Foursquare API, but some sections are incomplete. Can you fill them in?

## Completed Code
You can find a [gist](https://gist.github.com/octopi/5688980) of the completed sections. Note that these use the client ID and client secret of a specific app I created---you must supply your own.
