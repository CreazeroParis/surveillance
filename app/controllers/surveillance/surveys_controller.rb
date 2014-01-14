module Surveillance
  class SurveysController < ApplicationController
    def index
      @surveys = current_project.surveys.published
    end

    def show
      @survey = current_project.surveys.find params[:id]
    end
  end
end