# frozen_string_literal: true

module MrSpeedyRuby
  module API
    module Endpoint
      # Class for calculating order
      # https://apitest.mrspeedy.ph/business-api/doc#calculate-order-request-params
      class CalculateOrder < Base
        def code
          1
        end

        def endpoint(version:)
          "/api/business/#{version}/calculate-order"
        end

        private

        def permitted_keys
          %i[matter vehicle_type_id total_weight_kg
             insurance_amount is_client_notification_enabled
             is_contact_person_notification_enabled
             is_route_optimizer_enabled loaders_count
             backpayment_details is_motobox_required points]
        end

        def required_keys
          %i[matter vehicle_type_id total_weight_kg
             insurance_amount is_client_notification_enabled
             is_contact_person_notification_enabled
             is_route_optimizer_enabled loaders_count
             backpayment_details is_motobox_required points]
        end
      end
    end
  end
end
