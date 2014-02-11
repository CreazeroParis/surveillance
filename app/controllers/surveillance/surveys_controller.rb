module Surveillance
  class SurveysController < Surveillance::ApplicationController
    expose(:surveys)
    expose(:survey, model: Surveillance::Survey)
  end
end
