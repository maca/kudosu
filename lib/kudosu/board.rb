module Kudosu
  class Board
    attr_accessor :cells

    def initialize(ary)
      self.cells = ary.flatten.map { |val| Cell.new(val) }
    end

    def solve
      board = attempt_solution || fork_board(values) until board
      self.cells = board.cells
      self
    end

    def values
      cells.map(&:value)
    end

    def print
      Printer.new(self).print
    end

    def rows
      cells.each_slice(9).to_a
    end

    def columns
      rows.transpose
    end

    def boxes
      sliced_cols = rows.map { |row| row.each_slice(3).to_a }.transpose
      sliced_cols.flatten.each_slice(9).to_a
    end

    def shuffle
      boxes.each { |box| box.shuffle.take(rand(5..7)).each(&:reset) }
      self
    end

    def solved?
      cells.all?(&:solved?)
    end

    def valid?
      MarkupRangeUtils.ranges_valid?(markup_ranges)
    end

    protected

    def unsolved_cells
      cells.reject(&:solved?)
    end

    def attempt_solution
      cells.each(&:reset_markup)

      until solved?
        MarkupRangeUtils.update_ranges_markup(markup_ranges)
        return if cells.none?(&:solve)
      end

      self
    end

    private

    def markup_ranges
      @ranges ||= rows + columns + boxes
    end

    def fork_board(values)
      board = Board.new(values)

      board.unsolved_cells.each do |cell|
        return board if board.attempt_solution
        cell.pick_random
        break unless board.valid?
      end

      fork_board(values)
    end
  end
end
