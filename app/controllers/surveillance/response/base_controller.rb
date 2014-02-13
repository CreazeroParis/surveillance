# encoding: utf-8

module Surveillance
  module Response
    class BaseController < Surveillance::ApplicationController
      expose(:attempts) { surveys.attempts }
      expose(:attempt, model: Surveillance::Attempt, attributes: :attempt_params, finder: :find_by_access_token)

      before_filter :survey_closed

      private

      def survey
        if params[:survey_id]
          Surveillance::Survey.find(params[:survey_id])
        elsif attempt && attempt.survey
          attempt.survey
        end
      end
      helper_method :survey

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
end