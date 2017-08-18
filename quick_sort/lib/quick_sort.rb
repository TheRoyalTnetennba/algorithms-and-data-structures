class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(arr)
    return arr if arr.size < 2
    pivot = arr[arr.size / 2]
    middle = arr.select { |i| i == pivot }
    left = arr.select { |i| i < pivot }
    right = arr.select { |i| i > pivot }
    sort1(left) + middle + sort1(right)
  end

  # In-place.
  def self.sort2!(arr, start = 0, length = arr.length, &prc)
    return arr if length < 2
    prc ||= Proc.new { |i, j| i <=> j }
    pivot_idx = partition(arr, start, length, &prc)
    sort2!(arr, start, pivot_idx - start, &prc)
    sort2!(arr, pivot_idx + 1, length - (pivot_idx - start + 1), &prc)
    arr
  end

  def self.partition(arr, start, length, &prc)
    prc ||= Proc.new { |i, j| i <=> j }
    pivot_idx = start
    pivot = arr[start]
    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot, arr[idx]) > 0
        arr[idx], arr[pivot_idx + 1] = arr[pivot_idx + 1], arr[idx]
        pivot_idx += 1
      end
    end
    arr[start], arr[pivot_idx] = arr[pivot_idx], arr[start]
    pivot_idx
  end
end
