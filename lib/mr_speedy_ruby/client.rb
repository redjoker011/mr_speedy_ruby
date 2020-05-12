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
      pickup_details = pickup.deep_symbolize_keys
      pickup_details.assert_required_keys(points_keys)
      pickup_details[:contact_person].to_h.assert_required_keys(contact_person_keys)

      delivery_details = delivery.deep_symbolize_keys
      delivery_details.assert_required_keys(points_keys)
      delivery_details[:contact_person].to_h.assert_required_keys(contact_person_keys)

      opts.deep_symbolize_keys.assert_required_keys(option_keys)

      endpoint = "/api/business/#{version}/calculate-order"
      url = build_url(endpoint, sandbox)
      # Set MOTORBIKE as default vehicle
      vehicle = opts[:vehicle_type_id] || MOTORBIKE

      payload = opts.merge({
        vehicle_type_id: vehicle,
        points: [pickup, delivery]
      })

      post(endpoint: url, token: @token, payload: payload)
    end

    private

    # Options Required Keys
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
  end
end
