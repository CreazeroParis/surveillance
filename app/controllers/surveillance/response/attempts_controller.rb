module Surveillance
  module Response
    class AttemptsController < Surveillance::Response::BaseController
      def new
        attempt = if previous_attempt
          if previous_attempt.completed?
            attempt_already_completed!(previous_attempt) and return
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
        store_attempt!(attempt)
      end

      def update
        attempt.answers.destroy_all # Clean old answers
        if attempt.update_attributes(attempt_params)
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

      private

      def cookie_key
        "survey-access-token-#{ survey.id }"
      end

      def previous_attempt
        @previous_attempt ||= if (token = cookies[cookie_key])
          Surveillance::Attempt.find_by_access_token(token)
        elsif (attempt = Surveillance::Attempt.find_by_ip_address(request.remote_ip))
          store_attempt!(attempt)
          attempt
        end
      end

      def store_attempt! attempt
        cookies[cookie_key] = {
          value: attempt.access_token,
          expires: 1.year.from_now
        }
      end

      def attempt_already_completed! attempt
        if (callback = Surveillance.attempt_already_registered_callback)
          instance_exec(attempt, &callback)
        else
          flash[:error] = t("surveillance.attempts.errors.already_completed")
          redirect_to surveys_path and return
        end
      end
    end
  end
end