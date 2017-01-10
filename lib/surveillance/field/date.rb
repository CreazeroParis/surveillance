module Surveillance
  module Field
    class Date < Base
      def present?
        answer && answer.content
      end

      def mandatory_content?
        true
      end

      def answer_string
        answer.content ? l(answer.content) : ''
      end
    end
  end
end
