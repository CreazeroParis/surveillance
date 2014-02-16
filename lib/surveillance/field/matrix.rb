module Surveillance
  module Field
    class Matrix < Base
      include OtherChoice
      setting :randomize_sub_questions, type: :boolean, default: false

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

      def view_name
        "matrix"
      end

      def present?
        question.questions.all? do |sub_question|
          field = sub_question.field(attempt: attempt)
          field.present?
        end
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

      def ordered_sub_questions
        if setting_value(:randomize_sub_questions) == "1"
          question.questions.sort_by { rand }
        else
          question.questions
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