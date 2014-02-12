module Surveillance
  module Admin
    class OptionsController < Surveillance::Admin::BaseController
      expose(:question,  model: Surveillance::Question, finder_parameter: :question_id)
      expose(:options) { question.options }
      expose(:option,  model: Surveillance::Option, attributes: :options_params)

      def create
        if option.save
          flash[:success] = flash_message(:success)
          redirect_to edit_admin_question_path(question)
        else
          flash[:error] = flash_message(:error)
          render "new"
        end
      end

      def edit
      end

      def update
        if option.update_attributes(options_params)
          flash[:success] = flash_message(:success)
          redirect_to edit_admin_question_path(option.question)
        else
          flash[:error] = flash_message(:error)
          render "edit"
        end
      end

      def destroy
        option.destroy
        flash[:success] = flash_message(:success)
        redirect_to edit_admin_question_path(option.question)
      end

      protected

      def options_params
        stong_parameters? ? params.require(:option).permit! : params[:option]
      end
    end
  end
end
