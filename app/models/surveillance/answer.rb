module Surveillance
  class Answer < ActiveRecord::Base
    belongs_to :attempt, class_name: "Surveillance::Attempt", inverse_of: :answers
    belongs_to :question, class_name: "Surveillance::Question"
    has_and_belongs_to_many :options, class_name: "Surveillance::Option",
      join_table: "surveillance_answers_options"

    has_one :content, class_name: "Surveillance::AnswerContent",
      foreign_key: :answer_id
    accepts_nested_attributes_for :content,
      reject_if: :optional_content_not_filled?

    validates_presence_of :question_id
    validates_with Surveillance::Validators::AnswerValidator

    def option
      options.first
    end

    def option_id
      option_ids.first
    end

    def option_id=(val)
      self.option_ids = [val]
    end

    def option_ids=(ids)
      ids = ids.reduce([]) do |ids_list, id|
        case id
        when "other" then self.other_choosed = true
        when /^\d+$/ then ids_list << id
        end
        ids_list
      end

      super(ids)
    end

    def content_or_build
      content || build_content
    end

    def optional_content_not_filled? attributes
      question.field.answer = self

      !question.field.mandatory_content? && !attributes["value"].presence
    end
  end
end