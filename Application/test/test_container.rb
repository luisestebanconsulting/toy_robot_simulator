#
#   test_container.rb     - (Mini)Test script for Container Class
#
#     Luis Esteban    20 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')


describe Container do
  
  before do
    @container = Container.new
  end

  describe "#inspect" do
    it "returns debug info of the container" do
      @container.inspect.must_match /^#<Container:0x/
    end
  end
  
  describe "Manages contents" do
    it "Is empty" do
      @container.size.must_equal 0
    end
    
    it "Contains one entity" do
      entity = Entity.new
      @container.size.must_equal 0
      @container.add entity
      @container.size.must_equal 1
      @container.contents[0].must_equal entity
      @container.contains?(entity).must_equal true
      entity.container.must_equal @container
    end
    
    it "Gaines and Loses an entity" do
      entity = Entity.new
      @container.size.must_equal 0
      @container.add entity
      @container.size.must_equal 1
      @container.remove entity
      @container.size.must_equal 0
      @container.contents[0].must_equal nil
      @container.contains?(entity).must_equal false
      entity.container.must_equal nil
    end
  end
  
end
