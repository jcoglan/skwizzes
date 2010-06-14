require 'forwardable'
require 'set'

class Hash
  # Apparently you can't use hashes as hash keys.
  # Yeah, yeah, I know.
  alias :eql? :==
end

module Anagrams
  def self.signature(word)
    table = Hash.new { |h,k| h[k] = 0 }
    word.downcase.scan(/[a-z]/).each { |c| table[c.to_sym] += 1 }
    table
  end
  
  def self.group_words(input_words)
    table = Hash.new { |h,k| h[k] = WordSet.new }
    input_words.each do |word|
      next unless word =~ /^[a-z]*$/i
      table[signature(word)].add(word)
    end
    table.values.sort
  end
  
  def self.display_in_groups(words)
    groups = group_words(words).inject({}) do |table, group|
      group.each { |word| table[word] = group }
      table
    end
    groups.keys.sort.map { |word| groups[word].display(word) }.compact
  end
  
  class WordSet < SortedSet
    include Comparable
    extend Forwardable
    def_delegators :entries, :first
    
    def <=>(other_set)
      first <=> other_set.first
    end
    
    def display(word)
      return nil if count < 2
      return word + " " + find { |w| w != word } if count == 2
      word == first ?
          entries.join(" ") :
          "#{ word } (See '#{ first }')"
    end
  end
end
