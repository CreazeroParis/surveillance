module Surveillance
  module Field
    class Matrix < Field::Base
      def choosable?
        true
      end

      def settings?
        true
      end

      def matrix?
        true
      end

      def has_sub_questions?
        true
      end

      def present?
        question.questions.map(&:field).all?(&:present?)
      end

      def answer
        @answer ||= if question.parent.is_a?(Surveillance::Question)
          attempt.answers.find do |answer|
            answer.question_id == question.id
          end
        else
          super
        end
      end

      def before_validation_callback
        question.questions.each do |sub_question|
          sub_question.field_type = "matrix_question"
          sub_question.mandatory = question.mandatory
        end
      end

      class << self
        def questions_fields_path
          "surveillance/field/matrix/questions_fields"
        end
      end
    end
  end
end