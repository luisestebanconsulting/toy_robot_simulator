#
#   table.rb   - Table Class
#
#     Luis Esteban    16 April 2015
#       Created
#


class Table < Environment
  
  DEFAULT_SIZE = 5
  
  def initialize(options = {})
    super
    @x_dimension ||= 0...DEFAULT_SIZE
    @y_dimension ||= 0...DEFAULT_SIZE
  end
  
  def exists_at?(x,y)
    @x_dimension === x and
    @y_dimension === y
  end
  
end
