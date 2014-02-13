module Surveillance
  module Field
    module OtherChoice
      extend ActiveSupport::Concern

      included do
        setting :other, type: :boolean, default: false
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