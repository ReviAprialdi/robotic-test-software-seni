require_relative 'robot'
require_relative 'table'

class Role
  def initialize
    @table = Table.new
    @robot = Robot.new
  end
  
  def run(command)
    return if command.strip.empty?

    tokens = command.split(/\s+/)
    operator = tokens.first
    arguments = tokens.last

    case operator
    when 'PLACE'
      place(arguments)
    when 'MOVE'
      move
    when 'LEFT'
      go_left
    when 'RIGHT'
      go_right
    when 'REPORT'
      report
    else
      "Invalid !"
    end
  end

  private
  
  def place(arguments)
    message = nil
    begin 
      coordinate = arguments.split(/,/)
      x = coordinate[0].to_i
      y = coordinate[1].to_i
      orientation = coordinate[2].downcase.to_sym

    unless @robot.orient(orientation) && @table.place(x,y)
      message = "Place is INVALID!"
    end
    rescue
      message = "Place is INVALID!"
    end
    message
  end

  def move
    return "ROBOT STILL NOT PLACED" unless @table.placed?
    vector = @robot.vector
    position = @table.position
    if @table.place(position[:x] + vector[:x], position[:y] + vector[:y])
      nil
    else
      'ROBOT AFFRAID TO FALL OFF.'
    end
  end

  def go_right
    return 'ROBOT STILL NOT PLACED.' unless @table.placed?
    @robot.right
    nil
  end

  def go_left
    return 'ROBOT STILL NOT PLACED.' unless @table.placed?
    @robot.left
    nil
  end

  def report
    return 'YOU ARE KIDDING, ROBOT STILL NOT PLACED. :)' unless @table.placed?
    position = @table.position
    orientation = @robot.orientation
    "#{position[:x]},#{position[:y]},#{orientation.to_s.upcase}"
  end



end
