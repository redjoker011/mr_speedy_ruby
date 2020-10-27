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

  def test_that_it_successfully_fetch_orders
    VCR.use_cassette("orders") do
      client = MrSpeedyRuby::Client.new(token: token)
      request = client.orders(sandbox: true)

      assert request["is_successful"]
    end
  end

  def test_that_it_successfully_fetch_completed_orders
    VCR.use_cassette("orders_by_status") do
      client = MrSpeedyRuby::Client.new(token: token)
      request = client.orders(sandbox: true, payload: { status: "completed" })

      assert request["is_successful"]
    end
  end

  def test_that_it_successfully_fetch_orders_with_limit
    VCR.use_cassette("orders_with_limit") do
      client = MrSpeedyRuby::Client.new(token: token)
      request = client.orders(sandbox: true, payload: { count: 1 })

      assert request["is_successful"]
    end
  end

  def test_that_it_successfully_fetch_orders_with_offset
    VCR.use_cassette("orders_with_offset") do
      client = MrSpeedyRuby::Client.new(token: token)
      request = client.orders(sandbox: true, payload: { offset: 1 })

      assert request["is_successful"]
    end
  end

  def test_that_it_raise_invalid_parameter_error
    VCR.use_cassette("raise_invalid_parameters") do
      client = MrSpeedyRuby::Client.new(token: token)

      resp = assert_raises MrSpeedyRuby::InvalidParameters do
        client.place_order(
          delivery: delivery_details,
          pickup: {
            address: "",
            contact_person: { name: "", phone: "" },
            packages: []
          },
          opts: { matter: nil },
          sandbox: true
        )
      end

      assert_includes resp.message, "Request parameters contain errors"
    end
  end
end
