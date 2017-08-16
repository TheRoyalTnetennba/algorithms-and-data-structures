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
    @max = -1.0/0
    @min = 1.0/0
  end

  def insert(num)
    @count += 1
    @max = num if num > @max
    @min  = num if num < @min
    self[num] = true
  end

  def remove(num)
    @count -= 1
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
    resize! unless @count < num_buckets
    @store[num % @num_buckets][num] = val
  end

  def resize!
    arr = []
    (@min..@max).each { |i| arr.push(i) if self.include?(i) }
    @num_buckets *= 2
    @count = 1
    @store = Array.new(@num_buckets) { Array.new }
    arr.each { |i| self.insert(i) }
  end
end
