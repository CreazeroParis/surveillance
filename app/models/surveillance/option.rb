module Surveillance
  class Option < ActiveRecord::Base
    has_and_belongs_to_many :answers, class_name: "Surveillance::Answer",
      join_table: "surveillance_answers_options"

    # include Sortable
    # sortable parent: :question

    belongs_to :question, class_name: "Surveillance::Question"

    validates_presence_of :title

    def answers_for question
      answers.select do |answer|
        answer.question_id == question.id
      end
    end
  end
end
