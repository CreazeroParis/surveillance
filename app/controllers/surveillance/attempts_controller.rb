# encoding: utf-8

module Surveillance
  class AttemptsController < ApplicationController
    expose(:survey, model: Surveillance::Survey, finder_parameter: :survey_id)
    expose(:attempts) { surveys.attempts }
    expose(:attempt,  model: Surveillance::Attempt, attributes: :attempt_params)

    before_filter :survey_closed

    def create
      attempt.ip_address = request.remote_ip

      if attempt.save
        if survey.last_page_description.presence
          redirect_to complete_survey_attempt_path(attempt.survey, attempt)
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

    def attempt_params
      stong_parameters? ? params.require(:attempt).permit! : params[:attempt]
    end

    def survey_closed
      if survey.closed?
        flash[:error] = "Ce sondage est maintenant fermé"
        redirect_to surveys_path
      end
    end
  end
end
