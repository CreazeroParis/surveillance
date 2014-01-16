module Surveillance
  class BranchRule < ActiveRecord::Base
    belongs_to :question
    belongs_to :sub_question, class_name: "Surveillance::Question"
    belongs_to :section
    belongs_to :option

    validates_presence_of :action, :condition

    def finalize_survey?
      action == "finalize_survey"
    end

    def goto_section?
      action == "goto_section"
    end

    def as_json options = {}
      attributes = [:condition, :action]
      attributes += [:question_id, :section_id, :option_id].select do |id|
        send(id).presence
      end
      super(only: attributes)
    end

    def matches? answer
      send(condition, answer)
    end

    def answers answer
      field = answer.question.field
      field.answer = answer
      field.present?
    end

    def doesnt_answer answer
      !answers(answer)
    end

    def answers_option answer
      qid = sub_question_id || question_id

      answer.options.any? do |option|
        option.id == option_id && option.question_id == qid
      end
    end

    def doesnt_answer_option answer
      !answers_option(answer)
    end
  end
end
