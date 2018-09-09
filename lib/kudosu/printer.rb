module Kudosu
  class Printer
    attr_accessor :board

    def initialize(board)
      self.board = board
    end

    def print
      board.rows.each do |row|
        print_separation
        puts '| ' + row.map{ |cell| cell.value || " " }.join(' | ') + ' |'
      end

      print_separation
    end

    private

    def print_separation
      puts '+' + '---+' * 9
    end
  end
end
