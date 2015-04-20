#
#   test_simulator.rb     - (Mini)Test script for Simulator Class
#
#     Luis Esteban    16 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')

TEST_INPUT = 'test_simulator_input.txt'

describe Simulator do
  
  describe "Simple command file input processing" do
    it "Processes a simple command file" do
      File.open(TEST_INPUT,'w') do |file|
        file.puts <<EOF
MOVE
REPORT
PLACE 1,2,EAST
MOVE
LEFT
MOVE
REPORT
EOF
      end
      out,err = capture_io do
        @simulator = Simulator.new [TEST_INPUT]
      end
      out.must_equal "2,3,NORTH\n"
      err.must_equal ""
    end
  end
  
  before do
    system("ruby ./programs/gen_test_progs.rb")
  end
  
  describe "Generated command file testing" do
    Dir["programs/test_prog_*"].sort.each do |filename|
      it "reads test program #{filename.inspect}" do
        out,err = capture_io do
          @simulator = Simulator.new [filename]
        end
        out.must_equal File.read(filename.sub(/test_prog_/,'test_rept_'))
        err.must_equal ""
      end
    end
  end
  
  after do
    if File.exist?(TEST_INPUT)
      File.delete(TEST_INPUT)
    end
  end
  
end
