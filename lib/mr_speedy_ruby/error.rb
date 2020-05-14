module MrSpeedyRuby
  # Base Error Class
  # @since 1.0.0-alpha.4
  #
  # @raise [Error] base error
  class Error < StandardError; end

  # Error Module
  # @since 1.0.0-alpha.4
  # @see https://apitest.mrspeedy.ph/business-api/doc#common-errors
  #
  # @raise [MrSpeedyError] base mr.speedy error
  class MrSpeedyError < Error
    def initialize(msg = nil)
      @message = msg
    end
  end

  # Mr.Speedy Unexpected Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy unexpected error
  class UnexpectedError < MrSpeedyError
    def to_s
      @message || "Unexpected error. Please let us know at api@mrspeedy.ph."
    end
  end

  # Mr.Speedy Invalid API Version Error Class
  # @since 1.0.0-alpah.4
  # @raise [Error] mr.speedy invalid api version error
  class InvalidAPIVersion < MrSpeedyError
    def to_s
      @message || "Unknown API version."
    end
  end

  # Mr.Speedy Required API Upgrade Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy required api upgrade error
  class RequiredAPIUpgrade < MrSpeedyError
    def to_s
      message = "Requested API version was discontinued."\
                " You should use the latest version instead."
      @message || message
    end
  end

  # Mr.Speedy Request Limit Exceeded Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy request limit exceeded error
  class RequestLimitExceeded < MrSpeedyError
    def to_s
      @message || "You have reached an API usage limit."
    end
  end

  # Mr.Speedy Required Auth Token Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy missing auth token error
  class RequiredAuthToken < MrSpeedyError
    def to_s
      @message || "X-DV-Auth-Token header is missing from the request."
    end
  end

  # Mr.Speedy Invalid Auth Token Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy invalid auth token error
  class InvalidAuthToken < MrSpeedyError
    def to_s
      @message || "X-DV-Auth-Token you are sending is invalid."
    end
  end

  # Mr.Speedy Required GET Method Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy invalid http method error
  class RequiredMethodGET < MrSpeedyError
    def to_s
      @message || "HTTP method GET is required."
    end
  end

  # Mr.Speedy Required POST Method Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy invalid http method error
  class RequiredMethodPOST < MrSpeedyError
    def to_s
      @message || "HTTP method POST is required."
    end
  end

  # Mr.Speedy Invalid POST Json Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy invalid post json error
  class InvalidPOSTJson < MrSpeedyError
    def to_s
      @message || "POST request body must be in JSON format."
    end
  end

  # Mr.Speedy Invalid Parameters Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy invalid parameters error
  class InvalidParameters < MrSpeedyError
    def to_s
      @message || "Request parameters contain errors"
    end
  end

  # Mr.Speedy Unapproved Contract Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy unapproved contract error
  class UnapprovedContract < MrSpeedyError
    def to_s
      @message || "Your agreement is not approved yet (for legal entities)."
    end
  end

  # Mr.Speedy Service Unavailable Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy service unavailable error
  class ServiceUnavailable < MrSpeedyError
    def to_s
      @message || "Our service is temporarily unavailable. Please try again later."
    end
  end

  # Mr.Speedy Invalid API Method Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy invalid api method error
  class InvalidAPIMethod < MrSpeedyError
    def to_s
      @message || "Unknown API method was requested."
    end
  end

  # Mr.Speedy Buyout Not Allowed Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy buyout not allowed error
  class BuyoutNotAllowed < MrSpeedyError
    def to_s
      @message || "You do not have access to buyout feature."
    end
  end

  # Mr.Speedy Order Cannot Be Edited Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy order cannot be edited error
  class OrderCannotBeEdited < MrSpeedyError
    def to_s
      @message || "Order cannot be edited."
    end
  end

  # Mr.Speedy Order Cannot Be Canceled Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy order cannot be edited error
  class OrderCannotBeCanceled < MrSpeedyError
    def to_s
      @message || "Order cannot be canceled."
    end
  end

  # Mr.Speedy Insufficient Balance Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy insufficient balance error
  class InsufficientBalance < MrSpeedyError
    def to_s
      @message || "Your balance is too low (for legal entities)."
    end
  end

  # Mr.Speedy Buyout Amount Limit Exceeded Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy buyout amount limit exceeded error
  class BuyoutAmountLimitExceeded < MrSpeedyError
    def to_s
      message = "Total buyout amount in your active orders is too large. "\
                "You do not have sufficient balance / credit limit to place"\
                " the new order."
      @message || message
    end
  end

  # Mr.Speedy Route Not Found Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy route not found error
  class RouteNotFound < MrSpeedyError
    def to_s
      @message || "Route not found."
    end
  end

  # Mr.Speedy Total Payment Amount Limit Exceeded Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy total payment amount limit exceeded error
  class TotalPaymentAmountLimitExceeded < MrSpeedyError
    def to_s
      @message || "Exceeded maximum order price."
    end
  end

  # Mr.Speedy Duplicate Order Error Class
  # @since 1.0.0-alpha.4
  # @raise [Error] mr.speedy duplicate order error
  class OrderIsDuplicate < MrSpeedyError
    def to_s
      @message || "Duplicate order rejected"
    end
  end
end
