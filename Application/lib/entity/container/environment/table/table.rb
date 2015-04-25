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
    
    @size ||= options[:size] || DEFAULT_SIZE
    @size   = 0   if @size < 0
    
    @x_dimension ||= 0...@size
    @y_dimension ||= 0...@size
  end
  
  def exists_at?(x,y)
    @x_dimension === x and
    @y_dimension === y
  end
  
end
