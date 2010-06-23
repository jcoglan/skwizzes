require File.dirname(__FILE__) + '/wolfram'

describe Wolfram::Rule do
  describe ".from_int" do
    let(:rule) { Wolfram::Rule }
    
    def neighborhoods(int)
      rule.from_int(int).active_neighborhoods
    end
    
    it "converts integers to rules" do
      rule.from_int(8).should be_a(Wolfram::Rule)
    end
    
    it "creates rules with the correct neighborhoods" do
      neighborhoods(0).should == []
      neighborhoods(1).should == [[0,0,0]]
      neighborhoods(2).should == [[0,0,1]]
      neighborhoods(3).should == [[0,0,0],[0,0,1]]
    end
  end
end

