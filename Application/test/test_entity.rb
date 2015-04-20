#
#   test_entity.rb     - (Mini)Test script for Entity Class
#
#     Luis Esteban    20 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')


describe Entity do
  
  before do
    @entity = Entity.new
  end

  describe "#inspect" do
    it "returns debug info of the entity" do
      @entity.inspect.must_match /^#<Entity:0x/
    end
  end
  
  describe "An uncontained entity" do
    it "is not put into a container" do
      @entity.container.must_equal nil
      @entity.contained?.must_equal false
      @entity.location.must_equal nil
    end
  end
  
end
