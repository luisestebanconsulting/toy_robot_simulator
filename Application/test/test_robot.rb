#
#   test_robot.rb     - (Mini)Test script for Robot Class
#
#     Luis Esteban    16 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')


describe Robot do
  
  before do
    @robot = Robot.new
  end

  describe "#inspect" do
    it "returns debug info of the robot" do
      @robot.inspect.must_match /^#<Robot:0x/
    end
  end
  
  describe "Following commands" do
    it "ignores unplaced movements" do
      assert_output("") do
        @robot.move
        @robot.report
      end
    end
    
    it "obeys placed movements" do
      assert_output("4,1,EAST\n") do
        table = Table.new
        table.place(@robot, [4,2])
        @robot.place(:south)
        @robot.move
        @robot.left
        @robot.report
      end
    end
  end
  
end
