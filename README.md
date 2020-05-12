# MrSpeedyRuby
[Mr.Speedy](https://mrspeedy.ph/) Api Integration For Ruby and Ruby On Rails
===

![Travis (.org)](https://img.shields.io/travis/redjoker011/mr_speedy_ruby)
![GitHub release (latest by date including pre-releases)](https://img.shields.io/github/v/release/redjoker011/mr_speedy_ruby?include_prereleases)
![Gem](https://img.shields.io/gem/v/mr_speedy_ruby)

[![GitHub license](https://img.shields.io/github/license/redjoker011/mr_speedy_ruby)](https://github.com/redjoker011/mr_speedy_ruby/blob/development/LICENSE.txt)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mr_speedy_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mr_speedy_ruby

## Usage
This gem will provide service for integrating mr.speedy in your ruby app with
ease.

### Initialize Client
We can initialize mr.speedy api client by providing authentication token
located in our mr.speedy account setting.

```ruby
MrSpeedyRuby::Client.new(token: "mr-speedy-token")
```

### Calculate Delivey Fee
Send request to mr.speedy api for delivery fee calculation by providing delivery
and pickup details

```ruby
client = MrSpeedyRuby::Client.new(token: "mr-speedy-token")

# Pickup Location Details Including Contact Person and Package
pickup = {
  address: "Capitol Park Homes, 71 Berlin Avenue, Matandang Balara, Quezon City, Metro Manila",
  contact_person: { name: "Admin One", phone: "639123456789" },
  packages: []
}

# Delivery Location Details Including Contact Person and Package
delivery = {
  address: "Unit 802, EcoTower, 32nd Street corner 9th Avenue, BGC, Taguig, 1634 Metro Manila",
  contact_person: { name: "Admin One", phone: "639123456789" },
  packages: []
}

# Additional Parameters
options = { matter: "Food" }

client.calculate_fees(delivery: delivery, pickup: pickup, opts: options, sandbox: true)
```

Theres so many things happening here first we initialize our client by providing
token , then we pass delivery details as separate entity from options so we can
easily validate required delivery details parameter. We also pass additional
required parameter `matter` which indicates parcel type and lastly we call
`MrSpeedyRuby::Client#calculate_fees` to send request for delivery fee
calculation to mr.speedy api.

Also note we pass `sandbox` parameter with true value to indicate that we want
to make a request on mr.speedy sandbox server.

##### Note:

[Order Price Calculation](https://apitest.mrspeedy.ph/business-api/doc#calculate-order) parameters can also be passed as options.

[Delivery Details](https://apitest.mrspeedy.ph/business-api/doc#calculate-order) can also be passed along pickup/delivery params.

By default we set `MOTORBIKE` as default vehicle unless you pass `vehicle_type_id` as option for `opts`.

### Placing an Order
Send request to mr.speedy api to create order.

```ruby
client = MrSpeedyRuby::Client.new(token: "mr-speedy-token")

# Pickup Location Details Including Contact Person and Package
pickup = {
  address: "Capitol Park Homes, 71 Berlin Avenue, Matandang Balara, Quezon City, Metro Manila",
  contact_person: { name: "Admin One", phone: "639277876287" },
  packages: []
}

# Delivery Location Details Including Contact Person and Package
delivery = {
  address: "Unit 802, EcoTower, 32nd Street corner 9th Avenue, BGC, Taguig, 1634 Metro Manila",
  contact_person: { name: "Admin One", phone: "639277876287" },
  packages: []
}

# Additional Parameters
options = { matter: "Food" }

client.place_order(delivery: delivery, pickup: pickup, opts: options, sandbox: true)
```
Like `delivery fee calculation` we also do the same steps and pass the exact
parameter to ensure that we have the same `delivery fee`, We also set `sandbox`
parameter to true to test our implementation against sandbox server.

##### Note:

[Order Creation](https://apitest.mrspeedy.ph/business-api/doc#create-order) parameters can also be passed as options.

[Delivery Details](https://apitest.mrspeedy.ph/business-api/doc#create-order) can also be passed along pickup/delivery params.

By default we set `MOTORBIKE` as default vehicle unless you pass `vehicle_type_id` as option for `opts`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).


### Features

- [x] Delivery Fee Calculation
- [x] Create Order
- [ ] Update Order
- [ ] Cancel Order
- [ ] Order List
- [ ] Courier Info and Location Tracker
- [ ] Create Draft Deliveries
- [ ] Update Draft Deliveries
- [ ] Draft Delivery Deletion
- [ ] Draft Delivery List
- [ ] API Setting Update
- [ ] Request Error Handling

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MrSpeedyRuby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/redjoker011/mr_speedy_ruby/blob/master/CODE_OF_CONDUCT.md).

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/redjoker011/mr_speedy_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Contributors
<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->

<table>
  <tr>
    <td align="center"><a href="https://github.com/redjoker011"><img src="https://avatars2.githubusercontent.com/u/22144212?v=4" width="100px;" alt=""/><br /><sub><b>Peter John Alvarado</b></sub></a><br /></td>
    <td align="center"><a href="https://github.com/cjbmartinez"><img src="https://avatars2.githubusercontent.com/u/34258568?v=4" width="100px;" alt=""/><br /><sub><b>Charles Martinez</b></sub></a><br /></td>
  </tr>
</table>

<!-- ALL-CONTRIBUTORS-LIST:END - Do not remove or modify this section -->
