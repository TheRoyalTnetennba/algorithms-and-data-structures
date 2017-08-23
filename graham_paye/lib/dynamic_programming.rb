class DynamicProgramming

  def initialize
    @blairs = [nil, 1, 2]
    @odds = [nil, 1, 3]
    @frog_cache = {
      1: [[1]],
      2: [[1,1], [2]]
      3: [[1,1,1], [1,2], [2,1], [3]]
    }
  end

  def blair_nums(n)
    return @blairs[n] if n < @blairs.length
    @odds.push(@odds[-1] + 2) until @odds.length == n
    until @blairs.length > n
      @blairs.push(@blairs[-2] + @blairs[-1] + @odds[@blairs.length - 1])
    end
    @blairs[n]
  end

  def frog_hops_bottom_up(n)

  end

  def frog_cache_builder(n)
    (1..n).each do |i|
      next if @frog_cache.key? i
      @frog_cache[i] = []
      new_hops =
  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
