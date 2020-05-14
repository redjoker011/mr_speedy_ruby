module MrSpeedyRuby
  # Mr Speedy Abstract Class
  # @since 0.1.0
  class Base
    require "net/http"
    require "uri"
    require "json"

    AUTH_TOKEN_HEADER="X-DV-Auth-Token".freeze
    PRODUCTION_BASE_URL="http://robot.mrspeedy.ph".freeze
    STAGING_BASE_URL="https://robotapitest.mrspeedy.ph".freeze

    # Constructor method
    # @since 1.0.0-alpha.3
    #
    # @attr_reader [String] token authentication token
    # @attr_reader [String] version api version
    attr_reader :token, :version

    def initialize(token:, version: "1.1")
      @token = token
      @version = version
    end


    # Endpoint Generator
    # @since v0.1.0
    #
    # @private
    #
    # @param [String] endpoint request endpoint
    # @param [Boolean] sandbox sandbox environment indicator
    #
    # @return [String] request endpoint
    def build_url(endpoint, sandbox)
      base_url = sandbox ? STAGING_BASE_URL : PRODUCTION_BASE_URL
      base_url + endpoint
    end

    # Send Post Request
    # @since v0.1.0
    # @param endpoint [String] request endpoint
    # @param token [String] app token
    # @param payload [Hash] message payload
    #
    # @return [Json] response
    def post(endpoint:, token:, payload:)
      response = send_request("post", endpoint, token, payload)

      response_body = JSON.parse(response.body)
      validate_error(response: response_body)

      response_body
    end

    # Send Get Request
    # @since 1.0.0-alpha.3
    # @param endpoint [String] request endpoint
    # @param token [String] app token
    # @param payload [Hash] message payload
    #
    # @return [Json] response
    def get(endpoint:, token:, payload: {})
      response = send_request("get", endpoint, token, payload)

      response_body = JSON.parse(response.body)
      validate_error(response: response_body)

      response_body
    end

    private

    # Request sender
    # @since v0.1.0
    #
    # @private
    #
    # @param endpoint [String] request endpoint
    # @param token [String] app token
    # @param payload [Hash] message payload
    #
    # @return [Json] request response
    def send_request(method, endpoint, token, payload)
      uri = URI.parse(endpoint)

      request = if method == "post"
                  Net::HTTP::Post.new(uri)
                else
                  # Encode payload as query parameters for GET method
                  uri.query = URI.encode_www_form( payload )
                  Net::HTTP::Get.new(uri)
                end

      request.add_field(AUTH_TOKEN_HEADER, token)

      request.body = JSON.dump payload
      options = { use_ssl: uri.scheme == "https" }

      Net::HTTP.start(uri.hostname, uri.port, options) do |http|
        http.request(request)
      end
    end

    # Error Validator
    # @since 1.0.0-alpha.4
    #
    # @raise [Error] response error
    def validate_error(response)
      success = response["is_successful"]
      error = response["errors"]&.first || ""
      MrSpeedyRuby::ErrorParser.raise_errors_from(code: error) unless success
    end
  end
end
