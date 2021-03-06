module Surveillance
  class Answer < ActiveRecord::Base
    belongs_to :attempt, class_name: "Surveillance::Attempt", inverse_of: :answers
    belongs_to :question, class_name: "Surveillance::Question"

    has_many :answers_options
    has_many :options, through: :answers_options

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

    def option_id=(id)
      self.option_ids = [id]
    end

    def option_ids=(ids)
      ids = ids.reduce([]) do |ids_list, id|
        case id
        when "other" then self.other_choosed = true
        when /^\d+$/ then ids_list << id.to_i
        end
        ids_list
      end

      options.dup.each do |option|
        options.delete(option) unless option.id.in? ids
      end

      super(ids)
    end

    def content_or_build
      content || build_content
    end

    def optional_content_not_filled? attributes
      question.field.answer = self

      if question.field.mandatory_content?
        (!question.mandatory && (!attributes["value"].presence))
      else
        !attributes["value"].presence
      end
    end
  end
end
