module Surveillance
  module Field
    class MultipleChoicesMatrix < Field::Matrix
      def settings_path
        "surveillance/field/matrix/settings"
      end
    end
  end
end