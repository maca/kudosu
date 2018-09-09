require "kudosu/version"
require "kudosu/markup_range_utils"
require "kudosu/board"
require "kudosu/cell"
require "kudosu/printer"

module Kudosu
  module_function

  def solve(values)
    Board.new(values).solve
  end

  def generate
    solve([[nil] * 9] * 9).shuffle
  end
end
