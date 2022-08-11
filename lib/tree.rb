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

  def tree_to_ary(curr_node = @root, ary)
    # Traverse and return array of tree
    return ary if ary.size == @size + 2

    tree_to_ary(curr_node.left, ary) unless curr_node.left.nil?
    tree_to_ary(curr_node.right, ary) unless curr_node.right.nil?
    # if ary.size == @size + 2
    #   ary.push(curr_node.data)
    #   return ary
    # end
    ary.push(curr_node.data)
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
    return nil if @root.nil?

    delete_rec(@root, value)
  end

  def  delete_rec(node, value)
    # 1. FIND
    if value < node.data
      node.left = delete_rec(node.left, value)
    elsif value > node.data
      node.right = delete_rec(node.right, value)
    else # FOUND! value == node.data! FOUND! ready to actually delete
      #@root.data = find_min(node.right).data if node.data == @root.data

      # 2. DELETE
      # case 1: no children (a leaf node)
      if node.left.nil? && node.right.nil?
        @size -= 1
        nil
      # case 2a: one right child -- don't need to find a next biggest
      elsif node.left.nil?
        temp = node # temp is 9
        node = node.right # 9 is replaced by 23 in its spot and is now 67's left child# because we have no node on the left
        temp.right = nil # unassign 9's pointer to 23 and now 9 is free floating
        @size -= 1
        node
      # case 2b: one left child -- don't need to find a next biggest
      elsif node.right.nil?
        temp = node
        node = node.left
        temp.left = nil
        @size -= 1
        node
      # case 3: two children
      else
        # need to find the next biggest node, which will replace current node!
        next_biggest = find_min(node.right)
        # now replace current node with the next biggest node, but DATA ONLY
        node.data = next_biggest.data
        # ready to DELETE the next biggest! now that the next biggest is found
        node.right = delete_rec(node.right, next_biggest.data)
      end
    end
    node
  end

  def find_min(node)
    # Find and return the smallest node in the right subtree
    until node.left.nil?
      node = node.left
    end
    node
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(value)
    # Returns node with the given value
    find_rec(@root, value)
  end

  def find_rec(node, value)
    if value == node.data
      return node
    elsif value > node.data
      find_rec(node.right, value)
    else # value < node.data
      find_rec(node.left, value)
    end
  end

  def level_order(&blk)
    return tree_to_ary([]) unless block_given?

    level_order_rec(&blk)
  end

  def level_order_rec(queue = [@root], &blk)
    # Recursively traverse a tree in level order, passing each node to the block
    return if queue.size.zero?


    node = queue.shift
    blk.call(node.data)

    queue.push(node.left) unless node.left.nil?
    queue.push(node.right) unless node.right.nil?
    level_order_rec(queue, &blk)
  end

  def level_order_it(queue = [@root])
    # Iteratively traverse a tree in level order, passing each node to the block
    return tree_to_ary([]) unless block_given?

    until queue.size.zero?
      node = queue.shift
      yield node.data
      queue.push(node.left) unless node.left.nil?
      queue.push(node.right) unless node.right.nil?
    end
  end

end
