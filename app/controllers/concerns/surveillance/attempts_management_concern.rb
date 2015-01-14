module Surveillance
  module AttemptsManagementConcern
    private

    def surveillance_attempt_cookie_key_for(survey)
      "survey-access-token-#{ survey.id }"
    end

    def previous_attempt
      @previous_attempt ||= previous_attempt_for(survey)
    end

    def previous_attempt_for(survey)
      if (token = cookies[surveillance_attempt_cookie_key_for(survey)])
        attempt = survey.attempts.find_by_access_token(token)
        return attempt if attempt
      end

      if (attempt = survey.attempts.find_by_ip_address(request.remote_ip))
        store_attempt!(attempt)
        return attempt
      end

      if respond_to?(:current_user) && current_user
        attempt = survey.attempts.where(
          surveillance_attempts: {
            user_id: current_user.id, user_type: current_user.class.name
          }
        ).first

        return attempt if attempt
      end
    end

    def store_attempt!(attempt)
      cookies[surveillance_attempt_cookie_key_for(attempt.survey)] = {
        value: attempt.access_token,
        expires: 1.year.from_now
      }
    end

    def attempt_already_completed! attempt
      if (callback = Surveillance.attempt_already_registered_callback)
        instance_exec(attempt, &callback)
      else
        flash[:error] = t("surveillance.attempts.errors.already_completed")
        redirect_to surveys_root_path and return
      end
    end
  end
end
