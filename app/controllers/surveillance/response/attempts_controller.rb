module Surveillance
  module Response
    class AttemptsController < Surveillance::Response::BaseController
      def new
        attempt.assign_attributes(
          last_answered_section: -1,
          ip_address: request.remote_ip,
          survey: survey
        )
        attempt.save
        redirect_to edit_response_attempt_path(attempt)
      end

      def edit
      end

      def update
        if attempt.save
          attempt.complete!
          if survey.last_page_description.presence
            redirect_to complete_response_attempt_path(attempt)
          else
            redirect_to survey_path(attempt.survey)
          end
        else
          flash[:error] = "Votre participation n'a pas pu être prise en compte.<br>" +
            "Merci de vérifier que tous les champs sont remplis correctement."
          render "new"
        end
      end

      def complete
      end
    end
  end
end