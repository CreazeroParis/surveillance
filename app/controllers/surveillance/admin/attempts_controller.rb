module Surveillance
  module Admin
    class AttemptsController < Surveillance::Admin::BaseController
      expose(:survey, model: Surveillance::Survey, finder_parameter: :survey_id)
      expose(:attempts) { survey.attempts }
      expose(:attempt,  model: Surveillance::Attempt, attributes: :attempt_params)

      def index
        self.attempts = attempts.includes_all
        self.survey = Surveillance::Survey.all_with_answers.find(survey.id)
      end

      def list
      end

      def overview
      end

      def show
        self.attempt = Surveillance::Attempt.includes_all.find(attempt.id)
        self.survey = Surveillance::Survey.includes_all.find(attempt.survey_id)
      end

      def destroy
        attempt.destroy
        flash[:success] = flash_message(:success)
        redirect_to admin_survey_attempts_path(attempt.survey)
      end

      protected

      def attempt_params
        stong_parameters? ? params.require(:attempt).permit! : params[:attempt]
      end
    end
  end
end
