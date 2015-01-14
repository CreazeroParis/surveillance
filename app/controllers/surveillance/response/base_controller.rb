# encoding: utf-8

module Surveillance
  module Response
    class BaseController < Surveillance::ApplicationController
      expose(:attempts) { surveys.attempts }
      expose(:attempt, model: Surveillance::Attempt, attributes: :attempt_params,
        finder: :find_by_access_token)

      before_filter :ensure_survey_available

      private

      def survey
        @survey ||= begin
          if (survey_id = params[:survey_id] || (attempt && attempt.survey_id))
            Surveillance::Survey.includes_all.where(id: survey_id).first
          end
        end
      end
      helper_method :survey

      def attempt_params
        stong_parameters? ? params.require(:attempt).permit! : params[:attempt]
      end

      def ensure_survey_available
        if !survey
          flash[:error] = t('surveillance.attempts.errors.no_survey_found')
          redirect_to surveys_root_path
        elsif survey.closed?
          flash[:error] = t('surveillance.attempts.errors.survey_closed')
          redirect_to surveys_root_path
        end
      end
    end
  end
end
