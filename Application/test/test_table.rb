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
    
    it "creates a Table with size as a number in a string" do
      table = Table.new size: '7'
      table.size.must_equal [0...7,0...7]
    end
    
    it "creates a Table with size as dots in a string" do
      table = Table.new size: '......'
      table.size.must_equal [0...6,0...6]
    end
    
  end
  
  describe "Tables can be rectangular" do
    10.times do
      x = rand(-3..18)
      y = rand(-3..18)
      
      size = [x,y]
      
      it "creates a Table of size #{size.inspect}" do
        table     = Table.new size: size
        
        safe_size_x  = size[0] < 0 ?  0 : size[0]
        safe_size_y  = size[1] < 0 ?  0 : size[1]
        outside_size = 2
        
        beyond = '.' * (safe_size_x + outside_size * 2)
        within = '.' * outside_size + '#' * safe_size_x + '.' * outside_size
        
        correct_map = ([beyond] * outside_size + [within] * safe_size_y + [beyond] * outside_size).join("\n")
        
        #$stderr.puts
        #$stderr.puts
        #$stderr.puts correct_map
        #$stderr.puts
        
        map         = ''
        
        x_min = [0,size[0]].min - outside_size
        y_min = [0,size[1]].min - outside_size
        
        x_max = size[0] + outside_size
        y_max = size[1] + outside_size
        
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
  
  describe "Tables can be sized in different ways" do
    it "creates a Table using nil size" do
      table = Table.new
    end
    
    [
      '(3,8)',
      '  (  3  ,  8  )  ',
      '[3,8]',
      ' 3 , 8 ',
      '3*8',
      '3x8',
      '3 8',
      '    3     8    ',
    ].each do |size|
      it "creates a Table using string size #{size.inspect}" do
        table = Table.new size: size
        table.size.must_equal [0...3,0...8]
      end
    end
  end
  
end
