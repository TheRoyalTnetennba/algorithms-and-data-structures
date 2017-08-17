require_relative 'heap'

def k_largest_elements(arr, k)

  prc = Proc.new { |i, j| i <=> j }
  (2..arr.size).each do |sub_len|
    BinaryMinHeap.heapify_up(arr, sub_len - 1, sub_len, &prc)
  end
  arr.size.downto(2).each do |sub_len|
    arr[sub_len - 1], arr[0] = arr[0], arr[sub_len - 1]
    BinaryMinHeap.heapify_down(arr, 0, sub_len - 1, &prc)
  end
  arr[0...k]
end
