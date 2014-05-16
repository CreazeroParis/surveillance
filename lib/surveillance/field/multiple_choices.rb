module Surveillance
  module Field
    class MultipleChoices < SingleChoice
      def options
        if display_other_field?(question)
          question.options + [ Option.new(id: "", title: settings.other.label) ]
        else
          question.options
        end
      end

      def overview_path
        "surveillance/field/single_choice/overview"
      end

      def other_option
        Option.new(title: settings.other.label)
      end

      def validate_answer answer
        self.answer = answer

        if question.mandatory && empty?
          answer.errors[:option_ids] << I18n.t("errors.messages.empty")
        end
      end
    end
  end
end