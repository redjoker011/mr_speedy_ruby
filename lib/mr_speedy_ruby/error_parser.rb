module MrSpeedyRuby
  # Error Parser Class
  # @since 1.0.0-alpha.4
  class ErrorParser
    # Mr.Speedy Error Codes
    # @since 1.0.0-alpha.4
    #
    # @see https://apitest.mrspeedy.ph/business-api/doc#common-errors
    ERROR_CODES = {
      "unexpected_error"                    => UnexpectedError,
      "invalid_api_version"                 => InvalidAPIVersion,
      "required_api_upgrade"                => RequiredAPIUpgrade,
      "request_limit_exceeded"              => RequestLimitExceeded,
      "required_auth_token"                 => RequiredAuthToken,
      "invalid_auth_token"                  => InvalidAuthToken,
      "required_method_get"                 => RequiredMethodGET,
      "required_method_post"                => RequiredMethodPOST,
      "invalid_post_json"                   => InvalidPOSTJson,
      "invalid_parameters"                  => InvalidParameters,
      "unapproved_contract"                 => UnapprovedContract,
      "service_unavailable"                 => ServiceUnavailable,
      "invalid_api_method"                  => InvalidAPIMethod,
      "buyout_not_allowed"                  => BuyoutNotAllowed,
      "order_cannot_be_edited"              => OrderCannotBeEdited,
      "order_cannot_be_canceled"            => OrderCannotBeCanceled,
      "insufficient_balance"                => InsufficientBalance,
      "buyout_amount_limit_exceeded"        => BuyoutAmountLimitExceeded,
      "route_not_found"                     => RouteNotFound,
      "total_payment_amount_limit_exceeded" => TotalPaymentAmountLimitExceeded,
      "order_is_duplicate"                  => OrderIsDuplicate,
    }.freeze

    class << self
      # Raise Error from Response Status
      # @param code [String] error code
      def raise_errors_from(code:, errors: nil)
        raise_error_for(code, errors)

        # Default to Unexpected Error
        raise UnexpectedError
      end

      private

      # Raise Error from Response Status
      # @param code [String] error code
      #
      # @private
      #
      # @raise [MrSpeedyRuby::MrSpeedyError] raise code based error
      def raise_error_for(code, errors)
        error = ERROR_CODES[code]
        return unless error

        if error == MrSpeedyRuby::InvalidParameters
          # Include parameter errors
          msg = "Request parameters contain errors, ERRORS: #{errors.inspect}"
          raise MrSpeedyRuby::InvalidParameters, msg
        else
          # Constantize string class
          # @see https://stackoverflow.com/a/5924541
          raise Object.const_get("MrSpeedyRuby::#{error}")
        end
      end
    end
  end
end
