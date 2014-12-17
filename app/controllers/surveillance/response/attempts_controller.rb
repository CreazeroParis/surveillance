module Surveillance
  module Response
    class AttemptsController < Surveillance::Response::BaseController
      include Surveillance::AttemptsManagementConcern

      def new
        self.attempt = if previous_attempt
          if previous_attempt.completed?
            attempt_already_completed!(previous_attempt)
            return
          end
          flash[:success] = t("surveillance.attempts.previous_attempt_recovered")
          previous_attempt
        else
          Surveillance::Attempt.create(
            last_answered_section: -1,
            ip_address: request.remote_ip,
            survey: survey
          )
        end

        redirect_to edit_response_attempt_path(attempt)
      end

      def edit
        attempt_already_completed!(attempt) and return if attempt.completed?
        self.attempt = Surveillance::Attempt.includes_all.find(attempt.id)
        store_attempt!(attempt)
      end

      def update
        if attempt.save!
          attempt.complete!
          if survey.last_page_description.presence
            redirect_to complete_response_attempt_path(attempt)
          else
            redirect_to survey_path(attempt.survey)
          end
        else
          flash[:error] = "Votre participation n'a pas pu être prise en compte.<br>" +
            "Merci de vérifier que tous les champs sont remplis correctement."
          render "edit"
        end
      end

      def complete
      end
    end
  end
end