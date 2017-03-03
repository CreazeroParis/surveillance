module Surveillance
  class AnswerContent < ActiveRecord::Base
    belongs_to :answer, class_name: "Surveillance::Answer", touch: true

    validates_presence_of :value
  end
end
