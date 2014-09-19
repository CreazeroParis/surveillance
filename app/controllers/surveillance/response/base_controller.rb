# encoding: utf-8

module Surveillance
  module Response
    class BaseController < Surveillance::ApplicationController
      expose(:attempts) { surveys.attempts }
      expose(:attempt, model: Surveillance::Attempt, attributes: :attempt_params,
        finder: :find_by_access_token)

      before_filter :survey_closed

      helper_method :surveys_root_path

      private

      def survey
        @survey ||= begin
          survey_id = params[:survey_id] || (attempt && attempt.survey_id)
          Surveillance::Survey.includes_all.find(survey_id) if survey_id
        end
      end
      helper_method :survey

      def attempt_params
        stong_parameters? ? params.require(:attempt).permit! : params[:attempt]
      end

      def survey_closed
        if survey.closed?
          flash[:error] = "Ce sondage est maintenant fermé"
          redirect_to surveys_root_path
        end
      end

      def surveys_root_path
        if (config = Surveillance.surveys_root_path)
          instance_exec(&config)
        else
          surveys_path
        end
      end
    end
  end
end