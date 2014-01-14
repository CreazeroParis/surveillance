module Surveillance
  module Field
    class MatrixQuestion < Field::Base
      def present?
        answer.option_ids.length > 0
      end

      def answer_string
        answer.options.map(&:title).join("|")
      end
    end
  end
end