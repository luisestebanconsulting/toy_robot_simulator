#
#   simulator.rb   - Simulator Class
#
#     Luis Esteban    16 April 2015
#       Created
#


class Simulator
  
  def initialize(argv = [])
    @logger = Logger.new
    @table  = Table.new
    @robot  = Robot.new
  end
  
end
