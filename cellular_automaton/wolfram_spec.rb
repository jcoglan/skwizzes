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
  
  describe "#transform" do
    describe "with a single-neighborhood rule" do
      let(:rule) { Wolfram::Rule.new([ [0,0,0] ]) }
      
      it "converts a single-cell entry correctly" do
        rule.process([0]).should == [1]
        rule.process([1]).should == [0]
      end
      
      it "converts a two-cell entry correctly" do
        rule.process([0,0]).should == [1,1]
        rule.process([0,1]).should == [0,0]
        rule.process([1,0]).should == [0,0]
        rule.process([1,1]).should == [0,0]
      end
    end
    
    describe "with a multi-neighborhood rule" do
      let(:rule) { Wolfram::Rule.new([ [0,1,1], [1,0,1] ]) }
      
      it "converts a single-cell entry correctly" do
        rule.process([0]).should == [0]
        rule.process([1]).should == [0]
      end
      
      it "converts a two-cell entry correctly" do
        rule.process([0,0]).should == [0,0]
        rule.process([0,1]).should == [0,0]
        rule.process([1,0]).should == [0,0]
        rule.process([1,1]).should == [1,0]
      end
      
      it "converts a three-cell entry correctly" do
        rule.process([0,0,0]).should == [0,0,0]
        rule.process([0,0,1]).should == [0,0,0]
        rule.process([0,1,0]).should == [0,0,0]
        rule.process([0,1,1]).should == [0,1,0]
        rule.process([1,0,0]).should == [0,0,0]
        rule.process([1,0,1]).should == [0,1,0]
        rule.process([1,1,0]).should == [1,0,0]
        rule.process([1,1,1]).should == [1,0,0]
      end
    end
  end
end

describe Wolfram::Cells do
  let(:cells) { Wolfram::Cells.new([0,1,1]) }
  
  it "provides a list of neighborhoods" do
    cells.neighborhoods.should == [ [0,0,1], [0,1,1], [1,1,0] ]
  end
end

