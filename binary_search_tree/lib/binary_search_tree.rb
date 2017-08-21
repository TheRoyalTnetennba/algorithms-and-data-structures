# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require 'bst_node'

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    insert!(value, @root) unless @root.nil?
    @root = BSTNode.new(value) if @root.nil?
  end

  def find(value, node = @root)
    return node if node.value == value
    if value < node.value
      return find(value, node.left) if node.left
    elsif value > node.value
      return find(value, node.right) if node.right
    end
    nil
  end

  def delete(value)
    @root = delete!(value, root)
  end

  # helper method for #delete:
  def maximum(node = @root)
    maximus = node
    maximus = maximus.right until maximus.right.nil?
    maximus
  end

  def depth(node = @root)
    return -1 if node.nil?
    if depth(node.left) > depth(node.right)
      bigger = depth(node.left) + 1
    else
      bigger = depth(node.right) + 1
    end
    bigger
  end

  def is_balanced?(node = @root)
    return true if node.nil?
    return false if (depth(node.left) - depth(node.right)).abs > 1
    is_balanced?(node.left) && is_balanced?(node.right)
  end

  def in_order_traversal(node = @root, arr = [])
    return [] if node.nil?
    arr = in_order_traversal(node.left, arr) if node.left
    arr << node.value
    arr = in_order_traversal(node.right, arr) if node.right
    arr
  end

  def self.depth(node)
    return -1 if node.nil?
    1 + [depth(node.left), depth(node.right)].max
  end

  private
  # optional helper methods go here:
  def insert!(value, papa)
    if value <= papa.value && papa.left
      insert!(value, papa.left)
    elsif value <= papa.value
      papa.left = BSTNode.new(value)
      papa.left.papa = papa
    elsif value > papa.value && papa.right
      insert!(value, papa.right)
    else
      papa.right = BSTNode.new(value)
      papa.right.papa = papa
    end
  end

  def delete!(value, papa)
    if value == papa.value && papa.left.nil? && papa.right.nil?
      nil
    elsif value == papa.value && papa.left && papa.right
      pivot = maximum(papa.left)
      pivot.papa.right = pivot.left
      pivot
    elsif value == papa.value && papa.left
      papa.left
    elsif value == papa.value && papa.right
      papa.right
    elsif value < papa.value
      papa.left = delete!(value, papa.left) unless papa.left.nil?
    elsif value > papa.value
      papa.right = delete!(value, papa.right) unless papa.right.nil?
    end
  end
end
