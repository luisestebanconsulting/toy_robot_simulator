#
#   gen_test_progs.rb   - Generate Test Programs for Testing
#
#     Luis Esteban    20 April 2015
#       Created
#

file_number = 0
file        = nil

test_dir = File.dirname(File.expand_path(__FILE__))

begin
  DATA.each_line do |line|
    case line
      when /^=+/
        file_number += 1
        file && file.close
        filename = File.join(test_dir,"test_prog_%02d" % file_number)
        file = File.open(filename,'w')
        
      when /^-+$/
        file && file.close
        filename = File.join(test_dir,"test_rept_%02d" % file_number)
        file = File.open(filename,'w')
        
      when /^\s*$/
      
      else
        file && file.print(line)
    end
  end
rescue
  file && file.close
end


__END__
============================= Reporting
REPORT
--------
============================= Placing
PLACE 0,0,NORTH
REPORT
--------
0,0,NORTH
========
PLACE 3,4,WEST
REPORT
--------
3,4,WEST
========
PLACE 5,5,SOUTH
REPORT
--------
========
PLACE
REPORT
--------
========
WRONG
REPORT
--------
========
PLACE 2,2,WRONG
REPORT
--------
========
PLACE 2,2
REPORT
--------
========
PLACE -1,-1,EAST
REPORT
--------
========
PLACE 0,9,SOUTH
REPORT
--------
============================= Moving
PLACE 0,0,NORTH
MOVE
REPORT
--------
0,1,NORTH
========
PLACE 0,0,NORTH
MOVE
MOVE
REPORT
--------
0,2,NORTH
========
PLACE 0,0,NORTH
MOVE
MOVE
MOVE
REPORT
--------
0,3,NORTH
========
PLACE 0,0,NORTH
MOVE
MOVE
MOVE
MOVE
REPORT
--------
0,4,NORTH
========
PLACE 0,0,NORTH
MOVE
MOVE
MOVE
MOVE
MOVE
REPORT
--------
0,4,NORTH
========
PLACE 0,0,NORTH
MOVE
MOVE
MOVE
MOVE
MOVE
MOVE
REPORT
--------
0,4,NORTH
========
PLACE 0,0,SOUTH
MOVE
REPORT
--------
0,0,SOUTH
========
PLACE 3,3,EAST
MOVE
REPORT
--------
4,3,EAST
========
PLACE 3,3,EAST
MOVE
MOVE
REPORT
--------
4,3,EAST
========
PLACE 3,3,EAST
MOVE
MOVE
MOVE
REPORT
--------
4,3,EAST
========
PLACE 0,0,WEST
MOVE
REPORT
--------
0,0,WEST
========
PLACE 1,1,WEST
MOVE
REPORT
--------
0,1,WEST
============================= Turning Left
PLACE 0,0,NORTH
LEFT
REPORT
--------
0,0,WEST
========
PLACE 2,2,NORTH
MOVE
LEFT
MOVE
REPORT
--------
1,3,WEST
========
PLACE 2,2,EAST
MOVE
LEFT
MOVE
REPORT
--------
3,3,NORTH
========
PLACE 2,2,SOUTH
MOVE
LEFT
MOVE
REPORT
--------
3,1,EAST
========
PLACE 2,2,WEST
MOVE
LEFT
MOVE
REPORT
--------
1,1,SOUTH
========
PLACE 1,2,EAST
MOVE
MOVE
LEFT
MOVE
REPORT
--------
3,3,NORTH
============================= Turning Right
PLACE 0,0,NORTH
RIGHT
REPORT
--------
0,0,EAST
========
PLACE 2,2,NORTH
MOVE
RIGHT
MOVE
REPORT
--------
3,3,EAST
========
PLACE 2,2,EAST
MOVE
RIGHT
MOVE
REPORT
--------
3,1,SOUTH
========
PLACE 2,2,SOUTH
MOVE
RIGHT
MOVE
REPORT
--------
1,1,WEST
========
PLACE 2,2,WEST
MOVE
RIGHT
MOVE
REPORT
--------
1,3,NORTH
========
PLACE 1,2,EAST
MOVE
MOVE
RIGHT
MOVE
REPORT
--------
3,1,SOUTH
============================= Extra
PLACE 1,2,EAST
MOVE
MOVE
RIGHT
MOVE
PLACE 3,4,NORTH
REPORT
--------
3,4,NORTH
========
PLACE 1,2,EAST
MOVE
MOVE
RIGHT
MOVE
PLACE 1,9,NORTH
REPORT
--------
3,1,SOUTH
