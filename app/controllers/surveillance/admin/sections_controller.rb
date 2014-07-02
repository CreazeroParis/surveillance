module Surveillance
  module Admin
    class SectionsController < Surveillance::Admin::BaseController
      expose(:survey, model: Surveillance::Survey, finder_parameter: :survey_id)
      expose(:sections) { survey.sections }
      expose(:section,  model: Surveillance::Section, attributes: :section_params)

      def index
      end

      def create
        section.survey_id = params[:survey_id]

        if section.save
          flash[:success] = flash_message(:success)
          redirect_to edit_admin_section_path(section)
        else
          flash[:error] = flash_message(:error)
          render "new"
        end
      end

      def update
        if section.save
          flash[:success] = flash_message(:success)
          redirect_to edit_admin_section_path(section)
        else
          flash[:error] = flash_message(:error)
          render "edit"
        end
      end

      def destroy
        section.destroy
        flash[:success] = flash_message(:success)
        redirect_to edit_admin_survey_path(section.survey)
      end

      protected

      def section_params
        stong_parameters? ? params.require(:section).permit! : params[:section]
      end
    end
  end
end
