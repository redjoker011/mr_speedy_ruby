# frozen_string_literal: true

module MrSpeedyRuby
  module API
    module Endpoint
      class Error < StandardError; end

      # Endpoint abstract class
      class Base
        attr_reader :params

        def initialize(**attributes)
          @attributes = attributes.each_with_object({}, &permitted_params)
                                  .tap do |hash|
            next if (keys = required_keys - hash.keys).empty?

            raise Error, "Required keys: #{keys.join(', ')}"
          end
        end

        private

        def permitted_params
          lambda do |(key, value), obj|
            next unless permitted_keys.include?(key)

            obj[key] = value
          end
        end

        def permitted_keys
          []
        end

        def required_keys
          []
        end
      end
    end
  end
end
