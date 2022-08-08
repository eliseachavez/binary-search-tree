# frozen_string_literal: true

require_relative 'node'

# Class that creates a balanced Binary Search Tree
class Tree
  def initialize(unsorted_ary)
    # Initialize the tree class
    ary = sort_and_delete_dupes(unsorted_ary)
    @root = build_tree(ary, 0, (ary.size - 1))
    @size = ary.size
  end

  def sort_and_delete_dupes(unsorted_ary)
    # Sort the array and delete duplicate numbers
    sorted_ary = mergesort(unsorted_ary)
    remove_duplicates(sorted_ary)
  end

  def mergesort(unsorted_ary)
    # Sort the array with mergesort and return that array
    return unsorted_ary if unsorted_ary.size < 2

    l = mergesort(unsorted_ary.slice!(0, unsorted_ary.size/2))
    r = mergesort(unsorted_ary)
    merge(l, r)
  end

  def merge(l, r)
    # Merge two sorted arrays
    sorted = []
    until l.size.zero? || r.size.zero?
      if l[0] < r[0]
        sorted.push(l[0])
        l.shift
      else
        sorted.push(r[0])
        r.shift
      end
    end
    sorted.push(l) unless l.size.zero?
    sorted.push(r) unless r.size.zero?
    sorted.flatten
  end

  def remove_duplicates(sorted)
    # Remove duplicates from a sorted array and return that array
    new_ary = []
    sorted.each do |item|
      new_ary.push(item) unless new_ary.any?(item)
    end
    new_ary
  end

  def build_tree(sorted, start_idx, end_idx)
    # Returns the level 0 root node
    return nil if start_idx > end_idx

    mid_idx = (start_idx + end_idx)/2
    new_node = Node.new(sorted[mid_idx])

    new_node.left = build_tree(sorted, start_idx, mid_idx - 1)
    new_node.right = build_tree(sorted, mid_idx + 1, end_idx)

    new_node
  end

  def tree_to_ary(curr_node, ary)
    # Traverse and return array of tree
    ary.push(tree_to_ary(curr_node.left, ary)) unless curr_node.left.nil?
    ary.push(tree_to_ary(curr_node.right, ary)) unless curr_node.right.nil?
    if curr_node == @root
      ary.push(curr_node.data)
      return ary
    end
    curr_node.data
  end

  def insert(value)
    # Insert a node initialized with value to the BST
    new_node = Node.new(value)
    curr_node = @root

    loop do
      if value < curr_node.data
        if curr_node.left.nil?
          curr_node.left = new_node
          @size += 1
          break
        else
          curr_node = curr_node.left
        end
      elsif value > curr_node.data
        if curr_node.right.nil?
          curr_node.right = new_node
          @size += 1
          break
        else
          curr_node = curr_node.right
        end
      else # number is equal (already in tree), do not add
        break
      end
    end
  end

  def delete(value)
    # Delete a node with passed value
    curr_node = @root
    prev_node = nil

    loop do
      if value == curr_node.data
        if has_children?(curr_node)
          remove_parent_node(@root, curr_node.data)
          break
        else
          remove_leaf_node(prev_node, curr_node)
          break
        end
      elsif value < curr_node.data
        if has_child?(curr_node.left)
          prev_node = curr_node
          curr_node = curr_node.left
        else
          puts "value not found; could not delete #{value}"
          break
        end
      else # value > curr_node.data
        if has_child?(curr_node.right)
          prev_node = curr_node
          curr_node = curr_node.right
        else
          puts "value not found; could not delete #{value}"
          break
        end
      end
    end
  end

  def remove_parent_node(node, data)
    tree_ary = tree_to_ary(node, [])
    tree_ary.delete(data) # because root would be last one added to ary from above method
    sorted_root_removed_ary = sort_and_delete_dupes(tree_ary)
    @root = build_tree(sorted_root_removed_ary, 0, sorted_root_removed_ary.size - 1)
    @size -= 1
  end

  def remove_leaf_node(prev_node, curr_node)
    # "Delete" a node by setting pointers to nil
    if prev_node.data > curr_node.data
      prev_node.left = nil
    elsif prev_node.data < curr_node.data
      prev_node.right = nil
    end
    @size -= 1
  end

  def has_child?(pointer)
    pointer.nil? ? false : true
  end

  def has_children?(node)
    if node.left || node.right
      true
    else
      false
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
