$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "mr_speedy_ruby"
require "vcr"
require "minitest/autorun"

VCR.configure do |config|
  config.cassette_library_dir = "fixtures/vcr_cassettes"
  config.hook_into :webmock
end
