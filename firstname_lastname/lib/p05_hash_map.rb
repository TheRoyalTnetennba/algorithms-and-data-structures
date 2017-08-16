require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  attr_reader :count
  include Enumerable
  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    return false if @count == 0
    @store[key.hash % num_buckets].include?(key)
  end

  def set(key, val)
    if include?(key)
      p "#{val}"
      @store[key.hash % num_buckets].update(key, val)
    else
      @count += 1
      resize! if @count > num_buckets
      @store[key.hash % num_buckets].append(key, val)
    end
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    if include?(key)
      @count -= 1
      @store[key.hash % num_buckets].remove(key)
    end
  end


  def each(&prc)
    @store.each do |bucket|
      bucket.each { |link| yield [link.key, link.val] }
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    old_store = @store
    @store = Array.new(num_buckets * 2) { LinkedList.new }
    @count = 0

    old_store.each do |bucket|
      bucket.each { |link| set(link.key, link.val) }
    end
  end

  def bucket(key)
    @store[key.hash % num_buckets]
  end
end
