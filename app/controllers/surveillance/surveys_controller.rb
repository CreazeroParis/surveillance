module Surveillance
  class SurveysController < ApplicationController
    expose(:surveys)
    expose(:survey, model: Surveillance::Survey)
  end
end
