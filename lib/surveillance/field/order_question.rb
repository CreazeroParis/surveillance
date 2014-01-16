module Surveillance
  module Field
    class OrderQuestion < Base
      def present?
        answer.content
      end

      def answer_string
        answer.content && (answer.content.value.to_i + 1)
      end

      # Overall answers
      def answers
        size = question.parent.questions.length
        question.answers.includes(:content).reduce(Array.new(size, 0)) do |ary, answer|
          ary[answer.content.value.to_i] += 1
          ary
        end
      end
    end
  end
end