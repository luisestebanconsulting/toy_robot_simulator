#
#   test_robot_simulator.rb   - Run All Tests for Robot Simulator Application
#
#     Luis Esteban    16 April 2015
#       Created
#

Dir[File.join(File.expand_path(File.dirname(__FILE__)),'**','*.rb')].each do |filename|
  next if File.expand_path(filename) == File.expand_path(__FILE__)
  File.open(filename) do |file|
    puts file.read.lines[0...3]
  end
  require filename
end
