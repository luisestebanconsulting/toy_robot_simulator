#
#   test_simulator.rb     - (Mini)Test script for Simulator Class
#
#     Luis Esteban    16 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')


describe Simulator do
  
  before do
    @simulator = Simulator.new
  end

  describe "#inspect" do
    it "returns debug info of the simulator" do
      @simulator.inspect.must_match /^#<Simulator:0x/
    end
  end
  
end
