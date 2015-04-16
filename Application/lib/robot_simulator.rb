#
#   robot_simulator.rb   - Toy Robot Simulator library require file
#
#     Luis Esteban    16 April 2015
#       Created
#

puts __FILE__

Dir[File.expand_path(File.join(File.dirname(__FILE__),'**','*.rb'))].each do |file|
  require file
end
