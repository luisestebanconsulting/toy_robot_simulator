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
  
  describe "Tables can be different sizes" do
    (-3..8).each do |size|
      it "creates a Table of size #{size}" do
        table     = Table.new size: size
        
        safe_size = size < 0 ?  0 : size
        outside_size = 2
        
        beyond = '.' * (safe_size + outside_size * 2)
        within = '.' * outside_size + '#' * safe_size + '.' * outside_size
        
        correct_map = ([beyond] * outside_size + [within] * safe_size + [beyond] * outside_size).join("\n")
        
        #$stderr.puts
        #$stderr.puts
        #$stderr.puts correct_map
        #$stderr.puts
        
        map         = ''
        
        x_min = [0,size].min - outside_size
        y_min = x_min
        
        x_max = size + outside_size
        y_max = x_max
        
        (y_min...y_max).to_a.reverse.each do |y|
          (x_min...x_max).each do |x|
            map += table.exists_at?(x,y) ? '#' : '.'
          end
          map += "\n"
        end
        
        map.strip!
        
        map.must_equal correct_map
      end
    end
  end
  
end
