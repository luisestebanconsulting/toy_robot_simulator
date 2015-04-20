#
#   entity.rb   - Entity Class
#
#     Luis Esteban    16 April 2015
#       Created
#


class Entity
  
  def initialize(options = {})
    @container = nil
  end
  
  def container
    @container
  end
  
  def container=(new_container)
    @container = new_container
  end
  
  def contained?
    !!@container
  end
  
  def location
    @container                    &&
    @container.is_a?(Environment) &&
    @container.location_of(self)  || nil
  end
  
end
