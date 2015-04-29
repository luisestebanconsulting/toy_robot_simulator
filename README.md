# Toy Robot Simulator
_Software Engineering Presentation_

> This is a software engineering project presenting various software engineering processes and concepts
that would be applied to a large project, even those the project is small.  
>  
The approach is a simulated agile approach.  This is done by simulating a trickle of new requirements by
segmenting the brief.  A test/behaviour driven development approach is taken.  The project is broken up
so that multiple developers can work simultaneously.  
>  
Although the techniques applied here may be excessive for a small project, small projects can easily become
large projects.  The techniques of Object Oriented Design and Parsing are applied to allow for significant
expansion.

## Introduction

This project consists of an application and library.  The project simulates the control of a simple robot on a simple desktop.
The application allows users to use software; while the library allows developers to use the software in another project.

## Download

This project assumes that you have [Ruby](https://www.ruby-lang.org/en/) (>=1.9) installed.

You can download the project using Git, or you can download a Zip file directly from the GitHub page.
Using Git has the advantage that you can keep up with further development of the project, and perhaps
even contribute to the project.

### Using Git

To download using Git, you will need to have Git installed.
If you do not have Git, go to the [Git download page](http://git-scm.com/downloads).

Then download using the Git clone command.
```Bash
git clone https://github.com/luisestebanconsulting/toy_robot_simulator.git
```

### Using Zip

1. Download the Zip file from GitHub (https://github.com/luisestebanconsulting/toy_robot_simulator).
2. Unzip into a desired directory.


## Requirements and Dependencies

This project assumes that you have [Ruby](https://www.ruby-lang.org/en/) (>=1.9) installed.

## Installation

The Toy Robot Simulator project does not require any system installation to run.

If you are planning to use the library for other projects, you can manually install
the library into your project.  In the future, this project will be available as a gem,
so that you can simply do:
```Ruby
require 'robot_simulator'
```

## Usage

There are two ways to use this project: as a standalone application, and as a library.


### Shell Command Usage

Use the shell of the operating system to change directory to the top level of the project directory.
Alternatively, you can modify the `PATH` to include the project directory, such as:

```Bash
export PATH=$PATH:/home/luis/projects/robot_simulator/Application/bin
```

If the operating system supports executable files (specifically executable Ruby scripts), then you can launch
a robot using the command `robot_simulator`; otherwise, you will need to launch it with Ruby, `ruby robot_simulator`.
Many default operating system setups do not include the current directory in PATH for executable files.  This can
be remedied in two ways:

* Use a relative path to launch the application,
* Modify the PATH to include the current directory (on shared computers this could be a security issue).

Use a relative path, such as:
```Bash
/home/luis/projects/robot_simulator/Application/bin$ ./robot_simulator -h
```

Modify the PATH to include the current directory, such as:
```Bash
export PATH=$PATH:.
```

#### Synopsis

```
robot_simulator 
robot_simulator -h
robot_simulator cmdfile
cat cmdfile | robot_simulator
```

The first usage, without arguments, is an interactive mode where the user types commands interactively with the simulator; unless
input comes from the output of another process.
The `-h` flag requests command line usage.
When a file argument is used, simulator commands are read from the file.  Only in the interactive mode is the `QUIT` command available
which terminates the program; otherwise, the program terminates at the end of the file.


#### Linux

```Bash
$ cd bin
$ robot_simulator [-h] [cmdfile]
```

#### Mac OS X

```Bash
$ cd bin
$ robot_simulator [-h] [cmdfile]
```
#### Windows

```DOS
C:> cd bin
C:> robot_simulator.bat [-h] [cmdfile]
```

### Robot Command Language

Commands are issued to the simulator according to the following railroad diagram.

![Syntax Diagram](./Design/CommandLanguageSyntax.png)

Note, the `QUIT` command is available in interactive mode only.


### Library Usage

To include the entire library,

```Ruby
require 'robot_simulator'
```

The following classes are available:

![Class Hierarchy Diagram](./Design/ClassDiagram.png)

* *Simulator*: creates the objects and runs the simulation
* *Logger*: logs messages for debugging
* *Parser*: a generic command line parser
* *Entity*: an object to be simulated
 * *Container*: an entity which contains entities
  * *Environment*: an entity which contains entities at specific locations
   * *Table*: an entity which contains entities at specific bounded locations
 * *Robot*: an entity which moves on a table

#### Simulator

A Simulator gathers together various objects and sends commands to them.
The Simulator class in `toy_robot_simulator` is not a generic simulator,
but rather specifically created for the toy robot simulation.

It expects the command line arguments to be passed to it, but defaults
will be used if they are omitted.

The defaults are:

* stdin is used for robot command input.

Unless input comes from a pipe, a prompt is issued for each command and errors
are sent to stderr; otherwise errors are sent to a log file (`robot_simulator.log`).

```Ruby
simulator = Simulator.new
simulator = Simulator.new ARGV
```

#### Logger

A Logger sends log messages to a file or stream, such as $stderr.

```Ruby
logger = Logger.new
logger = Logger.new log_to: 'my_log'

logger.puts "my message"      # Send the to message to the log output.
logger.delete_log             # If the log is a file and exists, it will be deleted.
```

#### Parser

A Parser reads lines of text from a file or stream, such as $stdin, and translates
the lines into object oriented messages to a target object.  A Parser is initialised
with a Hash of options.

*  `:input`          - The file to parse (could be stdin)
*  `:prompt`         - The prompt to use if stdin is interactive
*  `:errors`         - Errors are sent to this stream if not nil
*  `:rules`          - A Hash of RegExps and conversions (see below)
*  `:target`         - The object to which messages from matching rules are sent
*  `:stop_on_error`  - A Boolean indicating to stop parsing when a rule is not matched
*  `:default`        - An action for unmatched input
*  `:start`          - A Boolean indicating to start parsing immediately on creation


The options have the following defaults:

* `input:          STDIN           `    Default to input coming from stdin
* `prompt:         '> '            `    If input is stdin and not piped, this is the prompt
* `errors:         nil             `    Errors are not output
* `rules:          { /.*/ => true }`    Which means everyline is matched and thus sent to the target as a method
* `target:         self            `    Really only useful for subclasses with specific methods
* `stop_on_error:  false           `    Do not stop on errors (i.e. when no rules match input)
* `default:        nil             `    No default action
* `start:          nil             `    Don't start on creation

If `:input` or `:errors` are strings, then a file is opened for reading input or writing errors.

`:rules` should be a Hash in the form RegExp => action, e.g.:
```Ruby
  {
    /f\((\d+),(\d+)\)/  =>  [:func_f,:to_i,:to_i],
    /EVENT (.+)/        =>  [:send_event,[:downcase,:to_sym]],
    /QUIT/              =>  true
  }
```

The first element of the action is the method.
The remaining elements are the conversions to apply to each argument.

  E.g. 1  `/f\((\d+),(\d+)\)/ =>  [:func_f,:to_i,:to_i]`
    The two arguments are converted to integers.

  E.g. 2  `/EVENT (.+)/ =>  [:send_event,[:downcase,:to_sym]]`
    The argument is converted to a lowercase symbol.

  E.g. 3  `/QUIT/  =>  true`
    The matched string becomes the method, in this case `:quit` .
   



```Ruby
parser = Parser.new
parser = Parser.new \
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

parser.start
parser.stop
```

#### Entity

An Entity represents a generic object that is to be used in a Simulator.
For the entity to do anything useful, the Entity class should be used as a
base class for specific entities.

```Ruby
entity = Entity.new

entity.container                # Nil or the container it is contained in
entity.contained?               # Whether the entity is contained in a container or not
entity.location                 # The location of the entity if it is contained in an environment
```

#### Container

A Container is an Entity that can contain other Entities.

```Ruby
container = Container.new

container.contents              # Array of Entities contained in the container
container.contains?(entity)     # Whether the container containes the specified entity
container.add(entity)           # Contain the specific entity
container.remove(entity)        # Uncontain the specific entity
container.size                  # Number of entities contained in the container
```

#### Environment

An Environment is a container that adds the notion of location.
It creates an unbounded area where entities can placed at specific locations.
Derived classes can limit the available locations.

```Ruby
environment = Environment.new
an_entity   = Entity.new
location    = [3,4]

environment.add(an_entity)                # Places the entity in the environment container, but without a location.
environment.place(an_entity, location)    # Places the entity in the environment container at the location.

environment.contents                      # Lists the entities in the environment.
an_entity.location                        # Outputs the location of the entity.
environment.location_of(an_entity)        # Also outputs the location of the entity.
environment.exists_at?(location)          # Returns whether the environment exists at the location (i.e. is it a valid location?).

environment.place(an_entity, :entrance)   # Named locations can also be used.  The semantics of locations is not managed by the Environment.
```

#### Table

A Table creates a flat rectangular limited environment.  The default size is 5 units x 5 units.

```Ruby
table = Table.new
```
Creates a default table.

```Ruby
table = Table.new size: rand(2..20)
```
Creates a table of random size between 2 to 20; thus squares from:
* (0,0) to (1,1), to
* (0,0) to (19,19)

```Ruby
table = Table.new size: '4'

```
Creates a square table 4 units x 4 units.

```Ruby
table = Table.new size: '(3,8)'
table = Table.new size: '[3,8]'
table = Table.new size: ' 3,8 '
table = Table.new size: ' 3*8 '
table = Table.new size: ' 3x8 '
table = Table.new size: ' 3 8 '

```
All create a rectangular table 3 units x 8 units.  This allows table size to be provided
as an option in ARGV and be processed properly by the Table class.



#### Robot

A Robot is a programmable entity that obeys commands.  Currently, the Robots only
execute commands immediately (i.e. they are not yet programmable).

```Ruby
robot = Robot.new

robot.place
robot.report
robot.move
robot.left
robot.right
```


## Testing

All the testing files can be run by

```
$ cd test
$ ruby test_robot_simulator.rb
```

Individual modules can be tested by running the corresponding test file, e.g.:

```
$ cd test
$ ruby test_robot.rb
```

A number of systematically generated test programs (i.e. robot command files) are located in
`Application/test/programs`.  These programs are contained in and generated by
`Application/test/programs/gen_test_progs.rb`.  This file can be modified to incorporate exhaustive testing.
Tests can be appended to the file in the format:

```
========
PLACE 2,2,NORTH
MOVE
LEFT
MOVE
REPORT
--------
1,3,WEST
========
PLACE 2,2,EAST
MOVE
LEFT
MOVE
REPORT
--------
3,3,NORTH
========
```
Lines containing any positive number of `=` characters separate tests.
Lines containing any positive number of `-` characters separate the input from the output (with the input coming first).

## History

Most recent work was:

* Allowed tables to be rectangular


```
* 4a34c33 2015-04-29 | Updated README, Made instances of entities in a container unique (HEAD, origin/master, origin/HEAD, master) [Luis Esteban]
* 5f9ef37 2015-04-25 | Allowed tables to be different sizes (library only) (see Documentation/Requirements.md) (HEAD, origin/master, origin/HEAD, master) [Lui
s Esteban]
* 6771994 2015-04-20 | Fixed link to syntax diagram in README.md (HEAD, origin/master, origin/HEAD, master) [Luis Esteban]
* 47c4b61 2015-04-20 | Created systematic tests, in particular for invalid commands and movements; also fixed bugs revealed from systematic testing (tag: v1.0
) [Luis Esteban]
* de2c242 2015-04-20 | Completed remaining empty classes (see Documentation/Requirements.md): Completed definitions of Entity classes (Entity, Container, Envi
ronment), of Robot and Table, and of the Simulator. (HEAD, origin/master, origin/HEAD, master) [Luis Esteban]
* 8af7281 2015-04-20 | Basic Logging and Basic Parsing (see Documentation/Requirements.md): Created Parser class, filled in basic functions of Logger class. (
HEAD, origin/master, origin/HEAD, master) [Luis Esteban]
* a671371 2015-04-16 | Empty infrastructure (Simulator, Entity/Robot. Entity/Container/Environment/Table, Logger) from initial client brief (see Documentation
/Requirements.md) (tag: v0.0) [Luis Esteban]
* 70acc71 2015-04-16 | Initial commit [Luis Esteban]
```

## Contributing

> The purpose of this project, being a presentation, precludes contributions. 

## Author

Luis Esteban M.Sc., M.Teach.


## License

(No License)

Copyright (c)2015

Due to the nature of this project, duplication is not permitted.  However, transfering this project to another computer is permitted for analysis purposes.
Modification is not permitted except for the purpose of providing feedback to author.


THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
