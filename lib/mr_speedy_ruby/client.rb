require "mr_speedy_ruby/base"
require "mr_speedy_ruby/lib/hash_refinement"

module MrSpeedyRuby
  # Mr Speedy API Client
  # @since 0.1.0
  class Client < Base
    using MrSpeedyRuby::Lib::HashRefinement
    # Vehicle Types
    # @see https://apitest.mrspeedy.ph/business-api/doc#vehicle-types
    CAR       = 7.freeze
    MOTORBIKE = 8.freeze

    # @attr_reader [String] token authentication token
    # @attr_reader [String] version api version
    attr_reader :token, :version

    def initialize(token:, version: "1.1")
      @token = token
      @version = version
    end

    # Delivery Fee Calculation
    # @since 0.1.0
    #
    # @param [Hash] pickup pickup location
    # @param pickup [String] :address delivery parcel pickup address
    # @param pickup [Hash] :contact_person delivery parcel pickup contact person
    # details
    # @param contact_person [String] :name delivery parcel pickup contact person
    #   name
    # @param contact_person [String] :phone delivery parcel pickup contact person
    # contact details(required)
    #
    # @param [Hash] delivery location
    # @param delivery [String] :address delivery parcel address
    # @param delivery [Hash] :contact_person delivery parcel contact person details
    # @param contact_person [String] :name delivery parcel contact person name
    # @param contact_person [String] :phone delivery parcel contact person
    # contact details(required)
    #
    # @param [Hash] opts additional details
    # @param opts [String] :matter delivery parcel type
    #
    # @param [Boolean] sandbox sandbox identifier(default false)
    #
    # @see https://apitest.mrspeedy.ph/business-api/doc#calculate-order
    def calculate_fees(pickup:, delivery:, opts: {}, sandbox: false)
      validate_delivery(details: pickup)
      validate_delivery(details: delivery)

      opts.deep_symbolize_keys.assert_required_keys(option_keys)

      endpoint = "/api/business/#{version}/calculate-order"
      url = build_url(endpoint, sandbox)
      payload = build_payload(opts: opts, pickup: pickup, delivery: delivery)

      post(endpoint: url, token: @token, payload: payload)
    end

    # Place Order
    # @since 0.1.0
    #
    # @param [Hash] pickup pickup location
    # @param pickup [String] :address delivery parcel pickup address
    # @param pickup [Hash] :contact_person delivery parcel pickup contact person
    # details
    # @param contact_person [String] :name delivery parcel pickup contact person
    #   name
    # @param contact_person [String] :phone delivery parcel pickup contact person
    # contact details(required)
    #
    # @param [Hash] delivery location
    # @param delivery [String] :address delivery parcel address
    # @param delivery [Hash] :contact_person delivery parcel contact person details
    # @param contact_person [String] :name delivery parcel contact person name
    # @param contact_person [String] :phone delivery parcel contact person
    # contact details(required)
    #
    # @param [Hash] opts additional details
    # @param opts [String] :matter delivery parcel type
    #
    # @param [Boolean] sandbox sandbox identifier(default false)
    #
    # @see https://apitest.mrspeedy.ph/business-api/doc#create-order
    def place_order(pickup:, delivery:, opts: {}, sandbox: false)
      validate_delivery(details: pickup)
      validate_delivery(details: delivery)

      opts.deep_symbolize_keys.assert_required_keys(option_keys)

      endpoint = "/api/business/#{version}/create-order"
      url = build_url(endpoint, sandbox)
      payload = build_payload(opts: opts, pickup: pickup, delivery: delivery)

      post(endpoint: url, token: @token, payload: payload)
    end

    private

    # Options Required Keys
    # @since 0.1.0
    #
    # @private
    #
    # @return [Array<String>]
    def option_keys
      %i[matter]
    end

    # Points Required Keys
    #
    # @private
    #
    # @return [Array<String>]
    def points_keys
      %i[packages]
    end

    # Contact Person Required Keys
    # @since 0.1.0
    #
    # @private
    #
    # @return [Array<String>]
    def contact_person_keys
      %i[phone]
    end

    # Package Required Keys
    #
    # @private
    #
    # @return [Array<String>]
    def package_keys
      %i[ware_code description items_count item_payment_amount]
    end

    # Delivery Details Validator
    # @since 0.1.0
    #
    # @private
    def validate_delivery(details:)
      delivery_details = details.deep_symbolize_keys
      delivery_details.assert_required_keys(points_keys)
      delivery_details[:contact_person].to_h.assert_required_keys(contact_person_keys)
    end

    # Payload Builder
    # @since 0.1.0
    #
    # @private
    #
    # @return [Hash]
    def build_payload(opts:, pickup:, delivery:)
      # Set MOTORBIKE as default vehicle
      vehicle = opts[:vehicle_type_id] || MOTORBIKE
      opts.merge({
        vehicle_type_id: vehicle,
        points: [pickup, delivery]
      })
    end
  end
end
