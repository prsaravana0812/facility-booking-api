# FACILITY BOOKING

...

## Requirements

- Ruby 3+
- Rails 7+
- Postgres 14+

## App setup instructions

1. #### Clone the app

&emsp;&emsp;`git clone git@code.spritle.com:in-house/facility-booking.git && cd facility-booking`

2. #### Install dependencies

&emsp;&emsp;`bundle install`

3. #### ENV and Database config

&emsp;&emsp;`cp .env.example .env` update your env values

&emsp;&emsp;`cp config/database.yml.example config/database.yml`

4. #### Database creation and migrations

&emsp;&emsp;`rake db:create db:migrate db:seed`

5. #### Start the server

&emsp;&emsp;`rails s`
