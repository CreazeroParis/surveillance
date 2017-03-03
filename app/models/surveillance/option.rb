module Surveillance
  class Option < ActiveRecord::Base

    has_many :answers_options
    has_many :answers, through: :answers_options

    belongs_to :question, class_name: "Surveillance::Question"

    validates_presence_of :title

    scope :ordered, -> { order("surveillance_options.id ASC") }

    def answers_for question
      answers.select do |answer|
        answer.question_id == question.id
      end
    end
  end
end
