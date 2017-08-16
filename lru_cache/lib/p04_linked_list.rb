class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    if @next && @prev
      @next.prev = @prev
      @prev.next = @next
    elsif @next
      @next.prev = nil
      @next = nil
    elsif @prev
      @prev.next = nil
      @prev = nil
    else
      @prev = nil
      @next = nil
    end

  end
end

class LinkedList
  include Enumerable

  def initialize(head= nil)
    @head = head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head
  end

  def last
    current = @head
    until current.next == nil
      current = current.next
    end
    current
  end

  def empty?
    if @head
      false
    else
      true
    end
  end

  def get(key)
    current = @head
    return nil unless @head
    return current.val if current.key == key
    until current.next == nil
      current = current.next
      return current.val if current.key == key
    end
    nil
  end

  def include?(key)
    current = @head
    return false unless @head
    return true if @head.key == key
    until current.next == nil
      current = current.next
      return true if current.key == key
    end
    false
  end

  def append(key, val)
    if @head
      link = Node.new(key, val)
      n = last
      link.prev = n
      n.next = link
    else
      @head = Node.new(key, val)
    end
  end

  def update(key, val)
    current = @head
    return false unless include? key
    if current.key == key
      current.val = val
      return val
    end
    until current.next == nil
      if current.key == key
        current.val = val
        return false
      end
      current = current.next

    end
    if current.key == key
      current.val = val
      return false
    end
  end

  def remove(key)
    return unless include? key
    return unless @head
    if @head.key == key
      n = @head.next
      @head.remove
      @head = n
      return
    end
    current = @head
    until current.next == nil
      current = current.next
      current.remove if current.key == key
    end
  end

  def each(&prc)
    prc ||= proc { |x| x }
    current = @head
    while current
      prc.call(current)
      current = current.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
