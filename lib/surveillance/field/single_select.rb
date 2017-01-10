module Surveillance
  module Field
    class SingleSelect < Base
      def choosable?
        true
      end

      def present?
        answer && answer.option_ids.any?
      end

      def view_name
        "choice"
      end

      def answer_string
        answer.first.try(:title)
      end

      def ordered_options
        question.options
      end

      def options_for_select
        ordered_options.map do |option|
          [option.title, option.id]
        end
      end
    end
  end
end
