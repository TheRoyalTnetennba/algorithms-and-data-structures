require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new { |i, j| j <=> i }
    (2..size).each do |sub_len|
      BinaryMinHeap.heapify_up(self, sub_len - 1, sub_len, &prc)
    end
    size.downto(2).each do |sub_len|
      self[sub_len - 1], self[0] = self[0], self[sub_len - 1]
      BinaryMinHeap.heapify_down(self, 0, sub_len - 1, &prc)
    end
  end
end
