#
#   test_logger.rb     - (Mini)Test script for Logger Class
#
#     Luis Esteban    16 April 2015
#       Created
#


require 'minitest/autorun'
require File.join(File.expand_path(File.dirname(__FILE__)),'..','lib','robot_simulator')

LOG_FILE = 'test.log'

describe Logger do
  
  before do
    @logger = Logger.new log_to: LOG_FILE
  end
  
  after do
    @logger.close
    @logger.delete_log
  end

  describe "#inspect" do
    it "returns debug info of the logger" do
      @logger.inspect.must_match /^#<Logger:0x/
    end
  end
  
  describe "Basic logging" do
    it "Outputs logging messages" do
      @logger.puts("Log message")
      @logger.close
      File.read(LOG_FILE).must_equal "Log message\n"
    end
  end
  
end
