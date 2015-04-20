#
#   test_environment.rb     - (Mini)Test script for Environment Class
#
#     Luis Esteban    20 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')


describe Environment do
  
  before do
    @environment = Environment.new
  end

  describe "#inspect" do
    it "returns debug info of the environment" do
      @environment.inspect.must_match /^#<Environment:0x/
    end
  end
  
  describe "Manages contents" do
    it "Is empty" do
      @environment.size.must_equal 0
    end
    
    it "Contains one entity" do
      entity = Entity.new
      @environment.size.must_equal 0
      @environment.add entity
      @environment.size.must_equal 1
      @environment.contents[0].must_equal entity
      @environment.contains?(entity).must_equal true
      entity.container.must_equal @environment
      entity.location.must_equal nil
      @environment.place(entity, [3,4])
      entity.location.must_equal [3,4]
    end
    
    it "Gaines and Loses an entity" do
      entity = Entity.new
      @environment.size.must_equal 0
      @environment.place entity, [0,0]
      entity.location.must_equal [0,0]
      @environment.size.must_equal 1
      @environment.remove entity
      @environment.size.must_equal 0
      @environment.contents[0].must_equal nil
      @environment.contains?(entity).must_equal false
      entity.container.must_equal nil
    end
  end
  
end
