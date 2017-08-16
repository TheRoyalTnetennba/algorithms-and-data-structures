require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @store = StaticArray.new(@capacity)
    @length = 0
  end

  # O(1)
  def [](index)
    raise('index out of bounds') if @length <= index || @length == 0
    @store[index]
  end

  def visualize
    arr = (0...@length).map { |i| @store[i] }
    p "Capacity: #{@capacity}"
    p "Length: #{@length}"
    p "Store: #{arr}"
  end

  # O(1)
  def []=(index, value)
    raise('index out of bounds') if @length <= index || @length == 0
    @store[index] = value
  end

  # O(1)
  def pop
    raise('index out of bounds') if @length == 0
    last = @store[(@length - 1)]
    @length -= 1
    last
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! unless @length < @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise('index out of bounds') if @length == 0
    first = @store[0]
    @length -= 1
    (0...@length).each do |i|
      @store[i] = @store[i + 1]
    end

    first
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    @length += 1
    resize! unless @length < @capacity
    @length.downto(0) do |i|
      @store[i] = @store[i - 1]
    end
    @store[0] = val

  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    (0...@length).each { |i| new_store[i] = @store[i] }
    @store = new_store
  end
end
