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
    @facing = f
  end
  
  def move(distance = 1)
    current_location = self.location
    
    return unless current_location
    return unless DIRECTIONS.include?(@facing)
    
    destination = current_location.add(
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
    current_location = self.location
    
    return unless current_location
    
    puts "%d,%d,%s" % [*current_location,@facing.to_s.upcase]
  end

private

  def turn(n = 1)
    return unless self.location
    
    @facing = DIRECTIONS[
      (DIRECTIONS.index(@facing) + n) % DIRECTIONS.size
    ]
  end
  
end
