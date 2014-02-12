module Surveillance
  module Admin
    class AttemptsController < Surveillance::Admin::BaseController
      expose(:survey, model: Surveillance::Survey, finder_parameter: :survey_id)
      expose(:attempts) { survey.attempts }
      expose(:attempt,  model: Surveillance::Attempt, attributes: :attempt_params)

      def index
      end

      def list
      end

      def overview
      end

      def show
      end

      protected

      def attempt_params
        stong_parameters? ? params.require(:attempt).permit! : params[:attempt]
      end
    end
  end
end
