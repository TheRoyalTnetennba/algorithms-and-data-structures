class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    # prc ||= Proc.new { |i, j| i <=> j }
    @prc = prc || Proc.new { |i, j| i <=> j }
    @store = []
  end

  def count
    @store.size
  end

  def extract
    return nil unless count > 1
    val = @store.first
    @store[0] = @store.pop
    self.class.heapify_down(@store, 0, &prc)
    val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    @store = self.class.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    n = parent_index * 2
    (1..2).map { |i| (n + i) }.select { |i| i < len }
  end

  def self.parent_index(child_index)
    raise 'root has no parent' if child_index.zero?
    (child_index - 1) / 2
  end

  def self.heapify_down(arr, papa, len = arr.length, &prc)
    prc ||= Proc.new { |i, j| i <=> j }
    papa_val = arr[papa]
    left, right = child_indices(len, papa)
    children = left ? [arr[left]] : []
    children << arr[right] if right
    return arr if children.all? { |child| prc.call(papa_val, child) <= 0 }
    change = 0
    if children.length == 1
      change = left
    else
      change = prc.call(children[0], children[1]) < 0 ? left : right
    end
    arr[papa], arr[change] = arr[change], papa_val
    heapify_down(arr, change, len, &prc)
  end

  def self.heapify_up(arr, child, len = arr.length, &prc)
    return arr if child.zero?
    papa = self.parent_index(child)
    return arr unless papa
    prc ||= Proc.new { |i, j| i <=> j }
    if prc.call(arr[papa], arr[child]) > 0
      arr[papa], arr[child] = arr[child], arr[papa]
      return self.heapify_up(arr, papa, len, &prc)
    end
    arr
  end
end
