#
#   test_table.rb     - (Mini)Test script for Table Class
#
#     Luis Esteban    16 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')


describe Table do
  
  before do
    @table = Table.new
  end

  describe "#inspect" do
    it "returns debug info of the table" do
      @table.inspect.must_match /^#<Table:0x/
    end
  end
  
end
