class BSTNode
  attr_accessor :value, :left, :right, :papa
  def initialize(value)
    @value = value
    @left = nil
    @right = nil
    @papa = nil
  end
end
