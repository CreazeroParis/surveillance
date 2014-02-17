module Surveillance
  module Field
    class Number < Text
      setting :minimum, type: :number, default: nil
      setting :maximum, type: :number, default: nil

      def view_name
        "number"
      end

      def validate_answer answer
        self.answer = answer

        if question.mandatory && empty?
          answer.errors[:present] << I18n.t("errors.messages.empty") and return
        end

        minimum = question.field.setting_value(:minimum).presence
        maximum = question.field.setting_value(:maximum).presence
        answer_value = answer.content.value.to_f

        if minimum && answer_value < minimum.to_f
          answer.errors[:present] << I18n.t(
            "errors.messages.greater_than_or_equal_to", count: minimum
          )
        elsif maximum && answer_value > maximum.to_f
          answer.errors[:present] << I18n.t(
            "errors.messages.less_than_or_equal_to", count: maximum
          )
        end
      end
    end
  end
end