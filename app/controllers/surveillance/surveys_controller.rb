module Surveillance
  class SurveysController < Surveillance::ApplicationController
    expose(:surveys) { Surveillance::Survey.published }
    expose(:survey, model: Surveillance::Survey)
  end
end
