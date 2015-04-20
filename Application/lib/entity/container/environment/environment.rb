#
#   environment.rb   - Environment Class
#
#     Luis Esteban    16 April 2015
#       Created
#


class Environment < Container
  
  def initialize(options = {})
    super
    @contents = {}
  end
  
  def contents
    @contents.keys
  end
  
  def add(entity,location = nil)
    entity.container = self
    @contents[entity] = location
  end
  
  def place(entity, location)
    add(entity, location)
  end
  
  def location_of(entity)
    @contents[entity]
  end
  
  def exists_at?(location)
    true
  end
  
end
