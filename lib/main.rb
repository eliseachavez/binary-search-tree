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

# DELETIONS #############################################
# delete ROOT node
BST.delete(8)
BST.pretty_print
# delete a leaf node
BST.delete(0)
BST.pretty_print
# delete a parent node
BST.delete(67)
BST.pretty_print
BST.delete(324)
BST.pretty_print
BST.delete(9)
BST.pretty_print
# request to delete a node that doesn't exist
#BST.delete(18)
node = BST.find(5)
puts "node found with 5 is #{node}"


