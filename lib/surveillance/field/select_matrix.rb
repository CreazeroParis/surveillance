module Surveillance
  module Field
    class SelectMatrix < Matrix
      def view_name
        "select-matrix"
      end

      def settings_path
        "surveillance/field/matrix/settings"
      end
    end
  end
end
