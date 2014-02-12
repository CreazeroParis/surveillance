module Surveillance
  module Admin
    module ExportsHelper
      def initialize_formats
        @formats = {
          black_background: Spreadsheet::Format.new(
            color: :white,
            size: 10,
            align: :left,
            border: :thin,
            pattern: 1,
            pattern_fg_color: :black
          ),
          gray: Spreadsheet::Format.new(
            color: :white,
            size: 10,
            align: :left,
            border: :thin,
            pattern: 1,
            pattern_fg_color: :gray
          ),
          border: Spreadsheet::Format.new(border: :thin),
          bold: Spreadsheet::Format.new(weight: :bold)
        }
      end

      # Format helper
      def set_format row, range, format
        @formats || initialize_formats
        # Assume int if `range` is not a Range
        range = (range..range) unless range.instance_of? Range
        # Set format to specified cells
        range.each { |n| @sheet.row(row).set_format(n, @formats[format]) }
      end
    end
  end
end