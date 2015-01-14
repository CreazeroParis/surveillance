module Surveillance
  class SurveysController < Surveillance::ApplicationController
    expose(:surveys)
    expose(:survey, model: Surveillance::Survey)

    def index
      self.surveys = surveys.published
    end
  end
end
