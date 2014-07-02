module Surveillance
  module Admin
    class SurveysController < Surveillance::Admin::BaseController
      expose(:surveys) { Surveillance::Survey.order("created_at DESC") }
      expose(:survey, attributes: :survey_params, model: Surveillance::Survey)

      def index
      end

      def create
        if survey.save
          flash[:success] = flash_message(:success)
          redirect_to edit_admin_survey_path(survey)
        else
          flash[:error] = flash_message(:error)
          render "new"
        end
      end

      def update
        if survey.update_attributes(survey_params)
          flash[:success] = flash_message(:success)
          redirect_to edit_admin_survey_path(survey)
        else
          flash[:error] = flash_message(:error)
          render "edit"
        end
      end

      def destroy
        survey.destroy
        flash[:success] = flash_message(:success)
        redirect_to admin_surveys_path
      end

      protected

      def survey_params
        stong_parameters? ? params.require(:survey).permit! : params[:survey]
      end
    end
  end
end
