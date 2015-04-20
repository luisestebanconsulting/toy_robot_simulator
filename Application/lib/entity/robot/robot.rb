#
#   robot.rb   - Robot Class
#
#     Luis Esteban    16 April 2015
#       Created
#


class Robot < Entity
  
  DIRECTIONS = [:north, :east, :south, :west]
  
  MOVES = {
    north:  [ 0, 1],
    south:  [ 0,-1],
    east:   [ 1, 0],
    west:   [-1, 0]
  }
  
  def initialize(options = {})
    @facing = nil
  end
  
  def place(f)
    return unless DIRECTIONS.include?(f)
    
    @facing = f
  end
  
  def move(distance = 1)
    return unless valid?
    
    destination = self.location.add(
      MOVES[@facing].scale(distance)
    )
    
    return unless self.container.exists_at?(*destination)
    
    self.container.place(self,destination)
  end
  
  def left(turns = -1)
    turn(turns)
  end
  
  def right(turns = 1)
    turn(turns)
  end
  
  def report
    return unless valid?
    
    puts "%d,%d,%s" % [*self.location,@facing.to_s.upcase]
  end

private

  def turn(n = 1)
    return unless self.location
    
    @facing = DIRECTIONS[
      (DIRECTIONS.index(@facing) + n) % DIRECTIONS.size
    ]
  end
  
  def valid?
    self.location and DIRECTIONS.include?(@facing)
  end
  
end
