module Surveillance
  class AttemptsController < ApplicationController
    load_and_authorize_resource :survey, class: "Surveillance::Survey"
    load_and_authorize_resource :attempt, through: :survey, class: "Surveillance::Attempt"

    before_filter :survey_closed

    def new
    end

    def create
      if current_participation
        @attempt.project_participation_id = current_participation.id
      end

      @attempt.ip_address = request.remote_ip

      if @attempt.save
        if @survey.last_page_description.presence
          redirect_to complete_survey_attempt_path(@attempt.survey, @attempt)
        else
          redirect_to survey_path(@attempt.survey)
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

    def survey_closed
      if @survey.closed?
        flash[:error] = "Ce sondage est maintenant fermé"
        redirect_to surveys_path
      end
    end

  end
end
