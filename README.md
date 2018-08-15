# RideShare
RideShare is web application that allows Andelans to offer or request a ride to some destination they are going to.

This README would normally document whatever steps are necessary to get the
application up and running.

### Features
A user is able to:
- Signin in using their Andela email accounts provided by google.
- View current ride offers posted by others.
- View current ride requests.
- Offer or create a ride offer.
- Create a ride Request.
- View there past ride offers and requests.
- Edit or Delete a ride offer or request
- Show interest in taking up a ride.
- Withdraw from a ride offer

### Technologies UsedRuby version
- Ruby Version 2.4
- Rails 5.2.0
- Postgres Database (10.4)

### Gem dependencies
``` devise, omniauth-google-oauth2, pg, rails  ~> 5.2.0, ```

### Getting started
Ensure that you have Technologies listed above before proceeding
* Clone this repository

      $ git clone https://github.com/emugaya/ride-share.git

* Change directory to `ride-share`

      $ cd ride-share
    
* Set environment variables according to your preference

      $ export RAILS_ENV=`development`
      $ export POSTGRES_DB=ride_share_dev
      $ export POSTGRES_USER=postgres
      $ export POSTGRES_PASSWORD=''
      $ export POSTGRES_HOST=localhost
      $ export 'RIDESHAREAPP_CLIENT_ID=`GOOGLE_CLIENT_ID`
      $ export RIDESHAREAPP_CLIENT_SECRET=`COOGLE_CLIENT_SECRET_KEY`
      $ export RAILS_HOST=localhost

* Database initialization
      
      $ bundle exec rake db:create
      $ bundle exec rake db:schema:load

* How to run the test suite

      $ rspec -f d
