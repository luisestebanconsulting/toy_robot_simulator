#
#   test_core_extensions.rb     - (Mini)Test script for Extensions to Ruby Core Classes
#
#     Luis Esteban    20 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')


describe Array do
  
  before do
    @array = [3,4]
  end
  
  describe "Addition" do
    it "adds [7,9]" do
      @array.add([7,9]).must_equal [10,13]
    end
    
    it "adds [-7,-9]" do
      @array.add([-7,-9]).must_equal [-4,-5]
    end
  end
  
  describe "Scaling" do
    it "scales by 10" do
      @array.scale(10).must_equal [30,40]
    end
    
    it "scales by -1" do
      @array.scale(-1).must_equal [-3,-4]
    end
  end
  
end
