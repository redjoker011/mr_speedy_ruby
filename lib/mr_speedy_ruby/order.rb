require "mr_speedy_ruby/base"

module MrSpeedyRuby
  # Mr Speedy API Order
  # @since 1.0.0-alpha.3
  class Order < Base
    # Order List
    # @since 1.0.0-alpha.3
    #
    # @param [Boolean] sandbox sandbox mode
    # @param [Hash] payload order query payload
    # @param payload [Integer, Array<Integer>] :order_id order id
    # @param payload [String] :status order status
    # @param payload [Integer] :offset order record offset count
    # @param payload [Integer] :count order record limit
    #
    # @see https://apitest.mrspeedy.ph/business-api/doc#orders
    #
    # @return [Json]
    def orders(payload: {}, sandbox: false)
      endpoint = "/api/business/#{version}/orders"
      url = build_url(endpoint, sandbox)

      get(endpoint: url, token: token, payload: payload)
    end
  end
end
