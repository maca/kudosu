module Kudosu
  module MarkupRangeUtils
    module_function

    def range_values(range)
      range.map(&:value).compact
    end

    def update_ranges_markup(ranges)
      ranges.each do |range|
        values = range_values(range)
        range.each { |cell| cell.remove_from_markup(values) }
      end
    end

    def ranges_valid?(ranges)
      ranges.all? do |range|
        values = range_values(range)
        values.uniq == values
      end
    end
  end
end
