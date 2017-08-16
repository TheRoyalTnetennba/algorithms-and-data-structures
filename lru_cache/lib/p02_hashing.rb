class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    num = self.length
    self.each_with_index { |n, i| num += n * i }
    num.hash
  end
end

class String
  def hash
    arr = self.split('')
    num = arr.length
    arr.each_with_index { |n, i| num += n.ord * i }
    num.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    num = 0
    self.keys.each { |k| num += (k.hash * self[k].hash) }
    num.hash
  end
end
