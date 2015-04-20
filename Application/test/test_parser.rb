#
#   test_parser.rb     - (Mini)Test script for Parser Class
#
#     Luis Esteban    20 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')

PARSER_INPUT = 'test_input.txt'


class Dummy
  
  # The Dummy class simply outputs what messages have been sent to it.
  
  def method_missing(method,*args,&block)
    puts "Called #{method.inspect} with (#{args.map{|x| x.inspect}.join(',')})"
  end
  
end


describe Parser do
  
  before do
    @target = Dummy.new
    
    File.open(PARSER_INPUT,'w') do |file|
      file.puts <<EOF
PLACE 1,2,EAST
MOVE
LEFT
RIGHT
REPORT
WRONG
LEFT
MOVE
MOVE
EOF
    end
    @parser = Parser.new \
      input:          PARSER_INPUT,
      stop_on_error:  true,
      errors:         nil,
      target:         @target,
      start:          false,
      rules:          {
        /PLACE (-?\d+),(-?\d+),([A-Z]+)/ => 
                          [:place, :to_i, :to_i, [:downcase, :to_sym]],
        /MOVE/          => true,
        /LEFT/          => true,
        /RIGHT/         => true,
        /REPORT/        => true,
      }
  end
  
  after do
    if File.exist?(PARSER_INPUT)
      File.delete(PARSER_INPUT)
    end
  end

  describe "#inspect" do
    it "returns debug info of the parser" do
      @parser.inspect.must_match /^#<Parser:0x/
    end
  end
  
  describe "simple parsing" do
    it "parses a file containing one of each command" do
      assert_output(<<EOF
Called :place with (1,2,:east)
Called :move with ()
Called :left with ()
Called :right with ()
Called :report with ()
EOF
) do
        @parser.start
      end
    end
  end
  
end
