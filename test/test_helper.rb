$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "mr_speedy_ruby"
require "vcr"
require "minitest/autorun"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end

def token
  "70B4ABCA8A35AC50E1585E27F217DF160F740D46"
end

def delivery_details
  {
    address: "Unit 802, EcoTower, 32nd Street corner 9th Avenue, BGC, Taguig, 1634 Metro Manila",
    contact_person: { name: "Reciever", phone: "639123456789" },
    packages: []
  }
end

def pickup_details
  {
    address: "Capitol Park Homes, 71 Berlin Avenue, Matandang Balara, Quezon City, Metro Manila",
    contact_person: { name: "Merchant", phone: "639123456789" },
    packages: []
  }
end
