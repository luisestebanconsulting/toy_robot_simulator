#
#   logger.rb   - Logger Class
#
#     Luis Esteban    16 April 2015
#       Created
#


class Logger
  
  def initialize(options = {})
    @log_file = options[:log_to] || "#{$0}.log"
    if @log_file.is_a?(String)
      @log_filename = @log_file
      @log_file = File.open(@log_file,'a+')
      
      ObjectSpace.define_finalizer(self, self.class.finalize(@log_file))
    end
  end
  
  def puts(*args)
    @log_file && @log_file.puts(*args)
  end
  
  def close
    @log_file && @log_file.close
    @log_file = nil
  end
  
  def delete_log
    if @log_filename
      if File.exist?(@log_filename)
        File.delete(@log_filename)
      end
    end
  end

private
 
  def self.finalize(file)
    proc {
      file.close        unless file.closed?
    }
  end
  
end
