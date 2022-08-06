# frozen_string_literal: true

require_relative 'node'

# Class that creates a balanced Binary Search Tree
class Tree
  def initialize(unsorted_ary)
    # Initialize the tree class
    ary = sort_and_delete_dupes(unsorted_ary)
    @root = build_tree(ary, 0, (ary.size - 1))
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end
end
