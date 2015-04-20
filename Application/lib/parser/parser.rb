#
#   parser.rb   - Parser Class
#
#     Luis Esteban    20 April 2015
#       Created
#

#
#   The Parser accepts a number of optional initialisation parameters:
#     :input          - The file to parse (could be stdin)
#     :prompt         - The prompt to use if stdin is interactive
#     :errors         - Errors are sent to this stream if not nil
#     :rules          - A Hash of RegExps and conversions (see below)
#     :target         - The object to which messages from matching rules are sent
#     :stop_on_error  - A Boolean indicating to stop parsing when a rule is not matched
#     :start          - A Boolean indicating to start parsing immediately
#
#   If :input or :errors are strings, then a file is opened for reading input or writing errors.
#
#   :rules should be a Hash in the form RegExp => action, e.g.:
#     {
#       /f\((\d+),(\d+)\)/  =>  [:func_f,:to_i,:to_i],
#       /EVENT (.+)/        =>  [:send_event,[:downcase,:to_sym]],
#       /QUIT/              =>  true
#     }
#   
#   The first element of the action is the method.
#   The remaining elements are the conversions to apply to each argument.
#   
#     E.g. 1  /f\((\d+),(\d+)\)/ =>  [:func_f,:to_i,:to_i]
#       The two arguments are converted to integers.
#   
#     E.g. 2  /EVENT (.+)/ =>  [:send_event,[:downcase,:to_sym]]
#       The argument is converted to a lowercase symbol.
#   
#     E.g. 3  /QUIT/  =>  true
#       The matched string becomes the method, in this case :quit .
#   
#


class Parser
  
  def initialize(options = {})
    @input          = options[:input]         || STDIN
    @prompt         = options[:prompt]        || '> '
    @errors         = options[:errors]        || nil
    @rules          = options[:rules]         || { /.*/ => true }
    @target         = options[:target]        || self
    @stop_on_error  = options[:stop_on_error] || false
    
    if @input.is_a?(String)
      @input_filename = @input
      @input = File.open(@input_filename,'r')
    end
    
    if @errors.is_a?(String)
      @errors_filename = @errors
      @errors = File.open(@errors_filename,'w')
    end
    
    self.start    if options[:start]
  end
  
  def start
    prompt = @input.isatty && @prompt && @prompt.to_s
    print prompt    if prompt
    @input.each_line do |line|
      matched = nil
      @rules.each do |expression,action|
        match = expression.match(line)
        if match
          matched = match
          
          if action == true
            # The matched string becomes the method
            
            method = match.string.strip.downcase.to_sym
            args   = []
          else
            # The first element of the action is the method.
            # The remaining elements are the conversions to apply to each argument.
            
            method = action[0]
            args   = action[1..-1]
            
            args = match.captures.zip(args).map do |capture,conversions|
              arg = capture
              [*conversions].compact.each do |conversion|
                arg = arg.send(conversion)
              end
              arg
            end
          end
          
          @target.send(method,*args)
          break
        end
      end
      
      unless matched
        if @errors
          @errors.puts "Parse error: #{line.strip.inspect} does not match any rule."
        end
        
        if @stop_on_error
          return false
        end
      end
      
      print prompt    if prompt
    end
    
    return true
  end
  
end
