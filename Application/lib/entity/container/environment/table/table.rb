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
    
    @x_size, @y_size = determine_size(options[:size])
    
    @x_dimension ||= 0...@x_size
    @y_dimension ||= 0...@y_size
  end
  
  def exists_at?(x,y)
    @x_dimension === x and
    @y_dimension === y
  end
  
  def size
    [@x_dimension.dup,@y_dimension.dup]
  end

private

  def determine_size(size)
    case size
      when NilClass
        x_size = y_size = DEFAULT_SIZE
        
      when String
        case size
          #(w,h)
          #[w,h]
          # w,h
          # w*h
          # wxh
          # w h
          when /^\s*[\[\(]?\s*(-?\d+)\s*[ ,\*x]\s*(-?\d+)\s*[\]\)]?\s*$/
            x_size = $1.to_i
            y_size = $2.to_i
          
          when /^(-?\d+)$/
            x_size = y_size = $1.to_i
          
          when /^(\.+)$/
            x_size = y_size = $1.length
          
          else
            x_size = y_size = DEFAULT_SIZE
        end
        
      when Integer
        x_size = y_size = size
        
      when Array
        x_size, y_size = size
        
      else
        x_size = y_size = DEFAULT_SIZE
    end
    
    x_size = 0    if x_size < 0
    y_size = 0    if y_size < 0
    
    x_size ||= DEFAULT_SIZE
    y_size ||= DEFAULT_SIZE
    
    [x_size, y_size]
  end
  
end
