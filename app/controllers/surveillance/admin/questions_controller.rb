module Surveillance
  module Admin
    class QuestionsController < Surveillance::ApplicationController
      expose(:section, model: Surveillance::Section, finder_parameter: :section_id)
      expose(:questions) { section.questions }
      expose(:question,  model: Surveillance::Question, attributes: :question_params)

      def index
      end

      def create
        question.parent_id = params[:section_id]
        question.parent_type = "Surveillance::Section"

        if question.save
          flash[:success] = flash_message(:success)
          redirect_to edit_admin_question_path(question)
        else
          flash[:error] = flash_message(:error)
          render "new"
        end
      end

      def update
        if question.update_attributes(question_params)
          flash[:success] = flash_message(:success)
          redirect_to edit_admin_question_path(question)
        else
          flash[:error] = flash_message(:error)
          render "edit"
        end
      end

      def edit_rules
        if question.update_attributes(params[:surveillance_question])
          flash[:success] = flash_message(:success)
          redirect_to edit_admin_section_path(question.parent)
        else
          flash[:error] = flash_message(:error)
          section = question.parent
          render "admin/surveillance/sections/edit"
        end
      end

      def destroy
        question.destroy
        flash[:success] = flash_message(:success)
        redirect_to edit_admin_section_path(question.parent)
      end

      protected

      def question_params
        stong_parameters? ? params.require(:question).permit! : params[:question]
      end
    end
  end
end

