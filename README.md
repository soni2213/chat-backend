# README

This is the backend repo for chat system.

Configuration:

Ruby: 3.0.1
Rails: 6.1.4


Clone the repo, and run the below commands to get started.

0. `bundle install`
1. `bundle exec rails db:create db:migrate`
2. `bundle exec rails s`

Channel creation and channel joining APIs are not exposed, and need to be done manually via
rails console for the time being.
Please use the below commands for the same:

Open rails console by typing `bundle exec rails c`

```
  4.times { Channel.create!(name: SecureRandom.hex(4)) }
```

To join a channel:

```
  user = User.first
  channel = Channel.first
  ChannelUser.create!(channel: channel, user: user)
```

## Postman collection
You can find the postman collection [here](https://www.getpostman.com/collections/cba257e597e41a640cde).
Please ensure you have `url` as `http://localhost:3000` set in your environment.

## Testing
I've used `rspec` for testing part, covering all endpoints.

To run the specs:
`bundle exec rspec`
