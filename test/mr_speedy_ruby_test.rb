require "test_helper"

class MrSpeedyRubyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::MrSpeedyRuby::VERSION
  end

  def test_that_it_successfully_request_delivery_fee
     VCR.use_cassette("delivery_fee") do
       client = MrSpeedyRuby::Client.new(token: token)
       request = client.calculate_fees(
         delivery: delivery_details,
         pickup: pickup_details,
         opts: { matter: "Food" },
         sandbox: true
       )
       assert request["is_successful"]
       refute_nil request["order"]["delivery_fee_amount"]
       refute_nil request["order"]["payment_amount"]
     end
  end

  def test_that_it_successfully_place_order
     VCR.use_cassette("place_order") do
       client = MrSpeedyRuby::Client.new(token: token)
       request = client.place_order(
         delivery: delivery_details,
         pickup: pickup_details,
         opts: { matter: "Food" },
         sandbox: true
       )
       assert request["is_successful"]
       refute_nil request["order"]["order_id"]
     end
  end
end
