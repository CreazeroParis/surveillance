module Surveillance
  module Field
    class Text < Field::Base
      def present?
        answer && answer.content
      end

      def mandatory_content?
        true
      end
    end
  end
end