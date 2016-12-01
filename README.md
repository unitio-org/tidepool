# Tidepool

Ruby wrapper for Tidepool API over HTTP

[![Build Status](https://travis-ci.org/unitio-org/tidepool.svg?branch=master)](https://travis-ci.org/unitio-org/tidepool)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tidepool'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tidepool

## Usage
```ruby
  response = Tidepool::Client.login(username: your_username, password: your_password)
  user_id = response["user_id"]
  session_token = response.headers["x-tidepool-session-token"]

  client = Tidepool::Client.new(session_token: session_token)

  users = client.users(user_id: user_id)
  users.inspect

  data = client.data(user_id: users.first["userid"])
  data.inspect

  notes = client.notes(user_id: users.first["userid"])
  notes.inspect
```
Options can be passed to the data and notes notes method

You can pass query options as follows
```ruby
client.data(user_id: "1234", options: { query: { type: "basal" } } )
```

All available parameters can be found here
https://github.com/tidepool-org/tide-whisperer/blob/master/tide-whisperer.go#L193

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/unitio-org/tidepool.

## Citation
 
T1D Exchange – Tidepool client library: An open source Ruby wrapper for the Tidepool API over HTTP, Boston MA.  URL: https://github.com/unitio-org/tidepool
 
## Acknowledgment
 
Thanks to T1D Exchange ( https://t1dexchange.org ) for their open source Tidepool API client ( https://github.com/unitio-org/tidepool ) that was used to retrieve data from the Tidepool platform. All analyses, content and conclusions presented herein are solely the responsibility of the authors and have not been reviewed or approved by the T1D Exchange.
