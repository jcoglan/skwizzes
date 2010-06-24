require 'rubygems'
require 'oyster'
require File.dirname(__FILE__) + '/wolfram'

parser = Oyster.spec do
  integer :rule
  integer :steps
  string  :cells
end

begin
  options = parser.parse(ARGV)
  rule    = Wolfram::Rule.from_int(options[:rule])
  steps   = options[:steps]
  input   = options[:cells].split('').map { |s| s.to_i }
  
  print_cells = lambda do |cells, step|
    string = cells.map { |x| x.zero? ? ' ' : 'X' }.join('')
    indent = options[:steps] + step
    puts "%0#{indent}s" % string
  end
  
  steps.times do |i|
    print_cells[input, i]
    input = rule.process([0] + input + [0])
  end
  
rescue Oyster::HelpRendered
end

