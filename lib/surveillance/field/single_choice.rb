module Surveillance
  module Field
    class SingleChoice < Base
      include OtherChoice
      setting :randomize, type: :boolean, default: false

      def choosable?
        true
      end

      def view_name
        "choice"
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

      def ordered_options
        if settings.randomize
          question.options.sort_by { rand }
        else
          question.options
        end
      end
    end
  end
end