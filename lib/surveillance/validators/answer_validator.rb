module Surveillance
  module Validators
    class AnswerValidator < ActiveModel::Validator
      def validate record
        record.question.field.validate_answer(record)
      end
    end
  end
end