module Surveillance
  module Field
    class SingleChoice < Base
      setting :other, type: :boolean, default: false

      def choosable?
        true
      end

      def view_name
        "single-choice"
      end

      def answer_string
        other_choosed? ? super : answer.options.map(&:title).join("|")
      end

      def validate_answer answer
        super

        if other_choosed? && !answer.content
          answer.errors[:content] << I18n.t("errors.messages.empty")
        end
      end

      def present?
        answer && answer.option_ids.length > 0 || other_choosed?
      end

      def mandatory_content?
        other_choosed?
      end

      def other_choosed?
        answer && answer.other_choosed
      end

      def display_other_field? question
        other = question.settings.find { |s| s.key == "other" }
        other ? (other.value == "1") : false
      end
    end
  end
end