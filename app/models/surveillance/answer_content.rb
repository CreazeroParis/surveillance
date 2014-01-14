module Surveillance
  class AnswerContent < ActiveRecord::Base
    belongs_to :answer, class_name: "Surveillance::Answer"

    validates_presence_of :value
  end
end
