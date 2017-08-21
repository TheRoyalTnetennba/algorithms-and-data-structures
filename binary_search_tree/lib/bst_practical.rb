require 'binary_search_tree'

# thith variable ith pronouthed "kaaaay-yyehhhhth"
# Seriously, why not just use n?
# nth, or "Inth" is a pronouncable thing.
# kth is literally unutterable, ineffable (unable to be effed)

def kth_largest(node, k)
  return nil unless node
  backwards_traversal(node)[k - 1]
end

def backwards_traversal(node, arr = [])
  return arr unless node
  arr = backwards_traversal(node.right, arr) if node.right
  arr << node
  arr = backwards_traversal(node.left, arr) if node.left
  arr
end
