# frozen_string_literal: true

require_relative 'tree'
require_relative 'node'

unsorted_ary = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
BST = Tree.new(unsorted_ary)
BST.pretty_print

# INSERTIONS ############################################
# add a number that already exists -- should not be added
BST.insert(4)
BST.pretty_print
# add a biggest number
BST.insert(7000)
BST.pretty_print
# add a smallest number
BST.insert(0)
BST.pretty_print

# TRAVERSALS ############################################
# call inorder, postorder, preorder with blocks
BST.preorder do |item|
  puts "#{item} in preorder!"
end

BST.inorder do |item|
  puts "#{item} is in the tree, yipee!"
end

BST.postorder do |item|
  puts "#{item} in postorder!"
end

# DELETIONS #############################################
# delete ROOT node
puts 'delete the ROOT node, 8'
BST.delete(8)
BST.pretty_print
# delete a leaf node
puts 'delete a leaf node, 0'
BST.delete(0)
BST.pretty_print
# delete a parent node
puts 'delete a parent node, 67'
BST.delete(67)
BST.pretty_print
puts 'delete a parent node, 324'
BST.delete(324)
BST.pretty_print
# request to delete a node that doesn't exist
# BST.delete(18)
node = BST.find(5)
puts "node found with 5 is #{node}"

# LEVEL ORDER ###########################################
BST.level_order do |item|
  puts item
end

BST.level_order_it do |item|
  item *= 2
  puts "this tree node times 2 is #{item}"
end

# call level order without block, which should return an array of tree
ary = BST.level_order
puts ary.to_s
ary = BST.level_order_it
puts ary.to_s
BST.pretty_print

# HEIGHT ################################################
height = BST.height(6345)
puts "height of BST(6345) is #{height}" # should be 1
height = BST.height(4)
puts "height of BST(4) is #{height}" # should be 2
height = BST.height(9)
puts "height of BST(9) is #{height}" # should be 3 (9-4-5-7)

# DEPTH #################################################
depth = BST.depth(7000)
puts "depth of node 7000 is #{depth}"
depth = BST.depth(9)
puts "depth of root node 9 is #{depth}"
depth = BST.depth(7)
puts "depth of node 7 is #{depth}"
# CHECK IF BALANCED and REBALANCE #####################################
puts "Is the tree balanced? #{BST.balanced?}"
BST.insert(-1)
BST.insert(-2)
BST.insert(-3)
puts 'The tree is now imbalanced, see?'
BST.pretty_print
BST.rebalance
puts 'Here is how the tree looks after calling rebalance'
BST.pretty_print
