module Kudosu
  class Cell
    attr_accessor :value, :markup

    def initialize(value)
      self.value = value
    end

    def solved?
      !value.nil?
    end

    def solve
      self.value = markup.pop if markup.one? unless solved?
    end

    def remove_from_markup(values)
      self.markup -= values
    end

    def pick_random
      self.value = markup.sample
      markup.delete(value)
    end

    def reset
      self.value = nil
    end

    def reset_markup
      self.markup = (1..9).to_a
    end
  end
end
