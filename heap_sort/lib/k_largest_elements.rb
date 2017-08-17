require_relative 'heap'

def k_largest_elements(arr, k)
  prc = Proc.new { |i, j| j <=> i }
  new_arr = []
  heap = BinaryMinHeap.new(&prc)
  arr.each { |i| heap.push(i) }
  k.times { new_arr << heap.extract }
  new_arr
end
