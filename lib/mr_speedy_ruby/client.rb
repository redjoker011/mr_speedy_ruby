module MrSpeedyRuby
  # Mr Speedy API Client
  # @since 0.1.0
  class Client < Base
    # Vehicle Types
    # @see https://apitest.mrspeedy.ph/business-api/doc#vehicle-types
    CAR       = 7.freeze
    MOTORBIKE = 8.freeze

    # @attr_reader [String] token authentication token
    # @attr_reader [String] version api version
    attr_reader :token, :version

    def self.initialize(token:, version: "1.1")
      @token = token
      @version = version
    end

    # Delivery Fee Calculation
    # @param [String] from pickup location
    # @param [String] to delivery location
    #
    # @see https://apitest.mrspeedy.ph/business-api/doc#calculate-order
    def calculate_fee(from:, to:, opts:, sandbox: false)
      endpoint = "api/business/#{version}/calculate-order"
      url = build_url(endpoint, sandbox)
      # Set MOTORBIKE as default vehicle
      vehicle = opts[:vehicle] || MOTORBIKE

      payload = opts.merge({
        vehicle: vehicle,
        points: [
          { address: from },
          { address: to }
        ]
      })

      post(endpoint: url, token: @token, payload: payload)
    end
  end
end
