#
#   container.rb   - Container Class
#
#     Luis Esteban    16 April 2015
#       Created
#


class Container < Entity
  
  def initialize(options = {})
    @contents = []
  end
  
  def contents
    @contents
  end
  
  def contains?(entity)
    self.contents.include?(entity)
  end
  
  def add(entity)
    entity.container = self
    self.contents << entity
    self.contents.uniq!
  end
  
  def remove(entity)
    entity.container = nil
    @contents.delete(entity)
  end
  
  def size
    self.contents.size
  end
  
end
