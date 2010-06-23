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
    
  end
end

