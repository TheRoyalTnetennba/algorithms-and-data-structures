require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    self.store = StaticArray.new(8)
    self.capacity = 8
    self.length = 0
    self.start_idx = 0
  end

  def [](index)
    check_index(index)
    self.store[(index + @start_idx) % @capacity]
  end

  def []=(index, val)
    check_index(index)
    self.store[(index + @start_idx) % @capacity] = val
  end

  def pop
    check_length
    val = self[@length - 1]
    self[@length - 1] = nil
    self.length -= 1
    val
  end

  def push(val)
    resize! if @length == @capacity
    self.length += 1
    self[@length - 1] = val
  end

  def shift
    check_length
    val = self[0]
    self[0] = nil
    self.start_idx = (@start_idx + 1) % @capacity
    self.length -= 1
    val
  end

  def unshift(val)
    resize! if @length == @capacity
    self.start_idx = (@start_idx - 1) % @capacity
    self.length += 1
    self[0] = val
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" unless (index >= 0) && (index < self.length)
  end

  def check_length
    raise "index out of bounds" if @length == 0
  end

  def resize!
    new_capacity = @capacity * 2
    new_store = StaticArray.new(new_capacity)
    self.length.times { |i| new_store[i] = self[i] }
    self.store = new_store
    self.capacity = new_capacity
    self.start_idx = 0
  end
end
