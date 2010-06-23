# With apologies to Stephen Wolfram
# http://en.wikipedia.org/wiki/Rule_110

module Wolfram
  
  class Rule
    # Should probably generate these
    NEIGHBORHOODS = [ [0,0,0],
                      [0,0,1],
                      [0,1,0],
                      [0,1,1],
                      [1,0,0],
                      [1,0,1],
                      [1,1,0],
                      [1,1,1] ]
    
    attr_reader :active_neighborhoods
    
    def self.from_int(integer)
      neighborhoods = []
      integer.to_s(2).split('').reverse.each_with_index do |digit, i|
        neighborhoods.push(NEIGHBORHOODS[i]) if digit == "1"
      end
      new(neighborhoods)
    end
    
    def initialize(active_neighborhoods = [])
      @active_neighborhoods = active_neighborhoods
    end
    
    def cell_value(cells, i)
      (0...cells.size).include?(i) ? cells[i] : 0
    end
    
    def process(input)
      cells = Cells.new(input)
      output = cells.neighborhoods.map do |neighborhood|
        @active_neighborhoods.include?(neighborhood) ? 1 : 0
      end
      [0] + output + [0]
    end
  end
  
  class Cells
    def initialize(values)
      @values = values
    end
    
    def neighborhoods
      output = []
      @values.each_with_index do |cell, i|
        output << [i-1, i, i+1].map(&method(:value_at))
      end
      output
    end
    
  private
    
    def value_at(i)
      (0...@values.size).include?(i) ? @values[i] : 0
    end
  end
  
end

