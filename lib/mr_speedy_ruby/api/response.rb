# frozen_string_literal: true

module MrSpeedyRuby
  module API
    # Response builder
    # https://apitest.mrspeedy.ph/business-api/doc#parameter-errors
    class Response
      attr_reader :hash_body, :api_code, :error

      # Constructor method
      # @since 1.0.0-alpha.3
      #
      # @param [Net::HTTPResponse] response from net http request
      # @param [Integer] api_code unique identifier of endpoint used
      def initialize(response:, api_code:)
        @api_code = api_code
        begin
          @hash_body = JSON.parse(response.body)
          return if hash_body['is_successful'] == true

          error_codes = hash_body['errors']
        rescue StandardError => e
          ex_msg = e.message
        end
        @error = Error.new(api_code: api_code,
                           error: "#{response.code} : #{response.message}",
                           codes: error_codes || [],
                           exception_message: ex_msg)
      end

      def success?
        error.nil?
      end

      def object
        return unless success?

        @object ||= OpenStruct.new(hash_body)
      end
    end
  end
end
