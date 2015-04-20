#
#   core_extensions.rb     - Extensions to Ruby Core Classes
#
#     Luis Esteban    20 April 2015
#       Created
#


# Create basic vector functions for arrays

class Array
  
  def add(vector)
    self.zip(vector).map{|d| d.inject{|s,t| (s || s.to_i) + (t || t.to_i) } }
  end
  
  def scale(scalar)
    self.map{|n| n * scalar }
  end
  
end
