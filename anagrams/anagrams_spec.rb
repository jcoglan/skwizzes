require 'anagrams'

describe Anagrams do
  INPUT_WORDS = [ "5th", "ascot", "ate", "carrot", "coast",
                  "coats", "cots", "Dorian", "eat", "halls",
                  "headskin", "inroad", "nakedish", "ordain",
                  "Ronald's", "shall", "sinkhead", "tacos",
                  "tea" ]
  
  describe ".signature" do
    it "returns a hash representing the letters in a word" do
      Anagrams.signature("carrot").should == {:c => 1, :a => 1, :r => 2, :o => 1, :t => 1}
    end
  end
  
  describe ".group_words" do
    it "groups the words into anagram groups sorted alphabeticly" do
      Anagrams.group_words(INPUT_WORDS).should == [
          %w(Dorian inroad ordain),
          %w(ascot coast coats tacos),
          %w(ate eat tea),
          %w(carrot),
          %w(cots),
          %w(halls shall),
          %w(headskin nakedish sinkhead)
      ]
    end
  end
  
  describe Anagrams::WordSet do
    def set(*words)
      word_set = Anagrams::WordSet.new
      words.each { |word| word_set.add word }
      word_set
    end
    
    describe "#display" do
      context "with one word" do
        before { @set = set("word") }
        
        it "displays nothing" do
          @set.display("word").should be_nil
        end
      end
      
      context "with two words" do
        before { @set = set("draw", "ward") }
        
        it "displays the list in full for each word" do
          @set.display("draw").should == "draw ward"
          @set.display("ward").should == "ward draw"
        end
      end
      
      context "with more than two words" do
        before { @set = set("coats", "coast", "ascot") }
        
        it "displays the first word with all anagrams" do
          @set.display("ascot").should == "ascot coast coats"
        end
        
        it "displays the other words by referring to the first" do
          @set.display("coats").should == "coats (See 'ascot')"
        end
      end
    end
  end
  
  describe ".display_in_groups" do
    it "returns display output for the anagrams in a list of words" do
      Anagrams.display_in_groups(INPUT_WORDS).should == [
           "Dorian inroad ordain",
           "ascot coast coats tacos",
           "ate eat tea",
           "coast (See 'ascot')",
           "coats (See 'ascot')",
           "eat (See 'ate')",
           "halls shall",
           "headskin nakedish sinkhead",
           "inroad (See 'Dorian')",
           "nakedish (See 'headskin')",
           "ordain (See 'Dorian')",
           "shall halls",
           "sinkhead (See 'headskin')",
           "tacos (See 'ascot')",
           "tea (See 'ate')"
      ]
    end
  end
  
end
