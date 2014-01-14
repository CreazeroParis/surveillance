module Surveillance
  class FieldSetting < ActiveRecord::Base
    belongs_to :question

    validates_presence_of :key, :value, :question_id
  end
end
