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
  
end
