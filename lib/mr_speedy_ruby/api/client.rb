# frozen_string_literal: true

require 'net/http'
require 'json'

module MrSpeedyRuby
  module API
    # Client class for initializing api requests
    class Client
      AUTH_TOKEN_HEADER = 'X-DV-Auth-Token'
      PRODUCTION_BASE_URL = 'https://robot.mrspeedy.ph'
      STAGING_BASE_URL = 'https://robotapitest.mrspeedy.ph'

      attr_reader :token, :version, :sandbox

      # Constructor method
      # @since 1.0.0-alpha.3
      #
      # @param [String] token authentication token
      # @param [String] version api version
      # @param [Boolean] sandbox for testing
      def initialize(token:, version: '1.1', sandbox: false)
        @token = token
        @version = version
        @sandbox = sandbox
      end

      def post(api:)
        uri = build_uri(api: api)
        request = Net::HTTP::Post.new(uri)
        request.body = JSON.dump api.params
        Response.new(
          response: start(request: request, uri: uri),
          api_code: api.code
        )
      end

      def get(api:)
        uri = build_uri(from: api)
        uri.query = URI.encode_www_form(api.params)
        request = Net::HTTP::Get.new(uri)
        Response.new(
          response: start(request: request, uri: uri),
          api_code: api.code
        )
      end

      private

      def base_url
        @base_url ||= sandbox ? STAGING_BASE_URL : PRODUCTION_BASE_URL
      end

      def build_uri(api:)
        URI.parse(base_url + api.endpoint(version: version))
      end

      def start(request:, uri:)
        options = { use_ssl: uri.scheme == 'https' }

        request.add_field(AUTH_TOKEN_HEADER, token)

        Net::HTTP.start(uri.hostname, uri.port, options) do |http|
          http.request(request)
        end
      end
    end
  end
end
