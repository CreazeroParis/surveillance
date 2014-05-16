module Surveillance
  module Field
    class Order < Matrix
      def choosable?
        false
      end

      def matrix?
        false
      end

      def view_name
        "order"
      end

      def present?
        question.questions.map(&:field).all? do |field|
          field.answer.content.presence
        end
      end

      def ordered_answers
        question.questions.sort do |q1, q2|
          field1 = q1.field
          field2 = q2.field
          field1.attempt ||= attempt
          field2.attempt ||= attempt
          field1.answer.content.value.to_i <=> field2.answer.content.value.to_i rescue 0
        end
      end

      def before_validation_callback
        question.questions.each do |sub_question|
          sub_question.field_type = "order_question"
          sub_question.mandatory = question.mandatory
        end
      end
    end
  end
end