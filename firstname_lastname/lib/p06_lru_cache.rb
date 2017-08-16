require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      update_node!(key)
      @map.get(key)
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    new_link = @store.append(key, val)
    @map[key] = new_link
    eject!
    val
  end

  def update_node!(node)
    n = [node, @store[node]]
    @store.remove(node)
    @store.append(n[0], n[1])
  end

  def eject!
    if count > @max
      @map.delete(@store.first.key)
      @store.remove(@store.first.key)
    end
  end
end
