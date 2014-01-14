module Surveillance
  module Admin
    class SectionsController < ApplicationController
      expose(:survey, model: "Surveillance::Survey", finder_parameter: :survey_id)
      expose(:sections) { survey.sections }
      expose(:section,  model: "Surveillance::Section", attributes: :section_params)

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
        if section.update_attributes(section_params)
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
        params.require(:section).permit!
      end
    end
  end
end
