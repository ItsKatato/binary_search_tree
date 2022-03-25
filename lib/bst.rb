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

  def insert(value, root = @root)
    return Node.new(value) if root.nil?

    if root.data == value
      root
    elsif root.data < value
      root.right = insert(value, root.right)
    else
      root.left = insert(value, root.left)
    end
    root
  end

  def find_smallest(root)
    root = root.left until root.left.nil?
    root
  end

  def delete(value, root = @root)
    return root if root.nil?

    if value < root.data
      root.left = delete(value, root.left)
    elsif value > root.data
      root.right = delete(value, root.right)
    elsif root.left.nil?
      root = root.right
    elsif root.right.nil?
      root = root.left
    else
      holder = find_smallest(root.right)
      root.data = holder.data
      root.right = delete(holder.data, root.right)
    end
    root
  end

  def find(value, root = @root)
    return root if root.data == value
    if value < root.data
      find(value, root.left)
    else
      find(value, root.right)
    end
  end

  def level_order(root = @root, arr = [], ordered_arr = [])
    return if root.nil?
    arr.push(root)
    while !arr.empty?
      current = arr.first
      if block_given?
        yield(current)
      end
      arr.push(current.left) if !current.left.nil?
      arr.push(current.right) if !current.right.nil?
      ordered_arr.push(arr.shift.data)
    end
    ordered_arr
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end

# bst = Tree.new(Array.new(15) { rand(1..100) })
bst = Tree.new([20, 30, 40, 50, 60, 70, 80])

bst.pretty_print

p bst.level_order
