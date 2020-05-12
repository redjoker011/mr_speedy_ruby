module MrSpeedyRuby
  module Lib
    # Hash Module Refinement
    # https://medium.com/rubycademy/refine-and-using-methods-in-ruby-part-i-2aef6d7a4325
    module HashRefinement
      extend self

      def symbolize_recursive(hash)
        {}.tap do |h|
          hash.each { |key, value| h[key.to_sym] = transform(value) }
        end
      end

      private

      def transform(thing)
        case thing
        when Hash; symbolize_recursive(thing)
        when Array; thing.map { |v| transform(v) }
        else; thing
        end
      end

      refine Hash do
        def deep_symbolize_keys
          HashRefinement.symbolize_recursive(self)
        end

        # Ensure Hash parameters are completed
        # https://coderwall.com/p/ne7owq/validating-hash-params-in-ruby
        def assert_required_keys(*keys)
          keys.flatten.each do |key|
            raise ArgumentError, "Required key: #{key.inspect}" unless key?(key)
          end
        end
      end
    end
  end
end
