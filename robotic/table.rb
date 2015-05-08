class Table
  attr_accessor :position
  
  def place(x,y)
    self.position = { x: x, y: y } if valid_coordinates(x, y)
  end

  def placed?
    self.position != nil
  end

  private
  #check vali coordinate
  def valid_coordinates(x, y)
    (x >= 0 && x <= 5 && y >= 0 && y <= 5)
  end
end
