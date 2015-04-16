#
#   test_logger.rb     - (Mini)Test script for Logger Class
#
#     Luis Esteban    16 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')


describe Logger do
  
  before do
    @logger = Logger.new
  end

  describe "#inspect" do
    it "returns debug info of the logger" do
      @logger.inspect.must_match /^#<Logger:0x/
    end
  end
  
end
