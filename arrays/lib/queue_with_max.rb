require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store

  def initialize
    @store = RingBuffer.new
    @max_tracker = RingBuffer.new
  end

  def enqueue(val)
    @store.push(val)
    @max_tracker.shift until @max_tracker.length.zero? if val >= max
    @max_tracker.push(val)
  end

  def dequeue
    val = @store.shift
    @max_tracker.shift if val == max
    val
  end

  def max
    @max_tracker.length.zero? ? 0 : @max_tracker[0]
  end

  def length
    @store.length
  end

end
