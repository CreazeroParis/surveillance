module Surveillance
  module Response
    class PartialAttemptsController < Surveillance::Response::BaseController
      def update
        attempt.answers.destroy_all # Clean old answers
        if attempt.update_attributes(attempt_params)
          head 200
        else
          render status: 422, json: {
            errors: attempt.errors.messages
          }
        end
      end
    end
  end
end