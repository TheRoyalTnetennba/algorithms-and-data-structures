require_relative "dynamic_array"

dyn = DynamicArray.new
dyn.push(1)
dyn.push(2)
dyn.unshift(0)
dyn.visualize
dyn.shift
dyn.visualize
