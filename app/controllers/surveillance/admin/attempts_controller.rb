module Surveillance
  module Admin
    class AttemptsController < ApplicationController
      load_and_authorize_resource :survey, class: "Surveillance::Survey"
      load_and_authorize_resource :attempt, through: :survey, class: "Surveillance::Attempt"

      before_filter :load_project

      def index
      end

      def list
      end

      def overview
      end

      def show
      end

      protected

      def load_project
        @survey ||= @attempt.survey
        @project = @survey.project
      end
    end
  end
end
