#
#   simulator.rb   - Simulator Class
#
#     Luis Esteban    16 April 2015
#       Created
#


class Simulator
  
  def initialize(argv = [])
    determine_usage(argv)
    
    return unless @input
    
    @logger = Logger.new
    @table  = Table.new
    @robot  = Robot.new
    @parser = Parser.new \
      input:    @input,
      errors:   @isatty && $stderr || @logger,
      prompt:   '> ',
      target:   self,
      rules:    {
        /PLACE (\d+),(\d+),([A-Z]+)/    => [:place,:to_i,:to_i,[:downcase,:to_sym]],
        /MOVE/                          => true,
        /LEFT/                          => true,
        /RIGHT/                         => true,
        /REPORT/                        => true,
        /QUIT/                          => @isatty,
      },
      default:       @isatty && [:help_commands] || nil
    
    @parser.start
  end

private
  
  def determine_usage(argv)
    case argv.size
      when 0
        @input  = STDIN
        @isatty = @input.isatty
      else
        if argv[0] == '-h'
          $stderr.puts "Usage: #{File.basename($0)} [-h] [cmdfile]"
        else
          @input = argv[0]
          unless File.exist?(@input)
            $stderr.puts "File #{@input.inspect} does not exist"
            @input = nil
          end
        end
    end
  end
  
  def place(x,y,f)
    return unless @table.exists_at?(x,y)
    
    @table.place(@robot, [x,y])
    @robot.place(f)
  end
  
  def move
    @robot.move
  end
  
  def left
    @robot.left
  end
  
  def right
    @robot.right
  end
  
  def report
    @robot.report
  end
  
  def quit
    @parser.stop
  end
  
  def help_commands(line)
    puts "Unknown command: #{line.inspect}"
    puts <<-EOF

      Valid commands are:
        PLACE x,y,f
        MOVE
        LEFT
        RIGHT
        REPORT
        QUIT
      EOF
  end
  
end
