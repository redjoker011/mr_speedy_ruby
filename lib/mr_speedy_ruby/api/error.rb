# frozen_string_literal: true

module MrSpeedyRuby
  module API
    # Error class for specific for APIs
    class Error < StandardError
      DEFAULT_ERROR = 'There seems to be a problem. Please try again later.'

      attr_reader :actual_error_message, :error_codes, :exception_message

      # Constructor method
      # @since 1.0.0-alpha.3
      #
      # @param [Integer] api_code unique identifier of endpoint used
      # @param [String] error is the actual request http error
      # @param [Array] codes error codes from MrSpeedy API
      # @param [String] exception_message exception encountered
      # from parsing responsed body
      def initialize(api_code:, error:, codes: [], exception_message:)
        @actual_error_message = error
        @error_codes = codes
        @exception_message = exception_message
        super("#{DEFAULT_ERROR} [Error##{api_code}]")
      end
    end
  end
end
