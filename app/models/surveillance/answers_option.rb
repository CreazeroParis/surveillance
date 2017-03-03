module Surveillance
  class AnswersOption < ActiveRecord::Base
    belongs_to :answer, class_name: 'Surveillance::Answer', touch: true
    belongs_to :option, class_name: 'Surveillance::Option'
  end
end
