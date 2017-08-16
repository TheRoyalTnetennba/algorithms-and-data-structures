class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(@max, false)
  end

  def insert(num)
    validate!(num)
    @store[num] = true
  end

  def remove(num)
    validate!(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num >= 0 && num < @max
  end

  def validate!(num)
    raise 'Out of bounds' unless is_valid?(num)
  end
end


class IntSet
  attr_accessor :num_buckets, :store

  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(@num_buckets) { Array.new }
  end

  def insert(num)
    self[num] = true
  end

  def remove(num)
    self[num] = false
  end

  def include?(num)
    self[num]
  end

  private

  def [](num)
    @store[num % @num_buckets][num]
  end

  def []=(num, val)
    @store[num % @num_buckets][num] = val
  end
end

class ResizingIntSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 20)
    @num_buckets = num_buckets
    @store = Array.new(@num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
  end

  def remove(num)
  end

  def include?(num)
  end

  private

  def [](num)
    @store[num % @num_buckets][num]
  end

  def []=(num, val)
    @store[num % @num_buckets][num] = val
  end

  def resize!
  end
end
