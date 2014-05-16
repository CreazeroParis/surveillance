module Surveillance
  module Field
    class MultipleChoicesMatrix < Matrix
      def settings_path
        "surveillance/field/matrix/settings"
      end

      def overview_path
        "surveillance/field/matrix/overview"
      end
    end
  end
end