# frozen_string_literal: true

# Mr Speedy Namespace Module
module MrSpeedyRuby
  # API class helpers
  module API
    autoload :Client, 'mr_speedy_ruby/api/client'
    autoload :Response, 'mr_speedy_ruby/api/response'
    autoload :Error, 'mr_speedy_ruby/api/Error'

    # Endpoints
    module Endpoint
      autoload :Base, 'mr_speedy_ruby/api/endpoint/base'
      autoload :CalculateOrder, 'mr_speedy_ruby/api/endpoint/calculate_order'
    end
  end
end
