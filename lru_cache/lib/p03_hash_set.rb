require_relative 'p02_hashing'

class HashSet
  attr_reader :count, :num_buckets

  def initialize(num_buckets = 8)
    @num_buckets = num_buckets
    @store = Array.new(@num_buckets) { Array.new }
    @count = 0
    @max = -1.0/0
    @min = 1.0/0
    @type_count = 179
    @type_hash = {}
  end

  def insert(num)
    numified = comfortably_num(num)
    @count += 1
    @max = numified if numified > @max
    @min  = numified if numified < @min
    self[num] = true
  end

  def remove(num)
    @count -= 1
    self[num] = false
  end

  def include?(num)
    p num
    p "#{num.class}"
    return false unless @type_hash.key?("#{num.class}")
    self[num] ? true : false
  end

  private

  def [](num)
    numified = comfortably_num(num)
    @store[numified % @num_buckets][numified]
  end

  def []=(num, val)
    numified = comfortably_num(num)
    resize! unless @count < num_buckets
    @store[numified % @num_buckets][numified] = val
  end

  def comfortably_num(num)
    unless @type_hash.key?("#{num.class}")
      @type_hash["#{num.class}"] = @type_count
      @type_count += 17
    end
    return num if num.is_a?(Integer)
    new_num = 0
    if num.is_a?(Hash)
      num.each { |k, v| new_num += ("#{k}".ord * "#{v}".ord) }
    else
      "#{num}".chars.each_with_index { |n, i| new_num += n.ord * i }
    end
    new_num * @type_hash["#{num.class}"]
  end

  def resize!
    arr = []
    ((@min.to_i)..(@max.to_i)).each { |i| arr.push(i) if self.include?(i) }
    @num_buckets *= 2
    @count = 1
    @store = Array.new(@num_buckets) { Array.new }
    arr.each { |i| self.insert(i) }
  end
end
