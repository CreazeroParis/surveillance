module Surveillance
  module Response
    class PartialAttemptsController < Surveillance::Response::BaseController
      def update
        if attempt.save
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