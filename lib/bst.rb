# Frozen_String_Literal: false

# class that creates the nodes in the tree
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

# class that holds the main tree and its methods
class Tree
  attr_accessor :root, :array

  def initialize(array)
    @array = array
    @root = build_tree(@array)
  end

  def build_tree(arr)
    if !arr || arr.empty?
      nil
    else
      middle = arr.length / 2
      middle_val = arr[(arr.length / 2)]
      root = Node.new(middle_val)
      root.left = build_tree(arr.slice(0...middle))
      root.right = build_tree(arr.slice((middle + 1)..(arr.index(arr.last))))
      root
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

bst = Tree.new([1, 4, 6, 11, 12, 16, 17, 18, 19, 20])

bst.pretty_print
