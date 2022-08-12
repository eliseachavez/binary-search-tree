# frozen_string_literal: true

require_relative 'node'
require_relative 'tree'

ary = Array.new(15) { rand(1..100) }
BST = Tree.new(ary)
BST.pretty_print
puts "Is tree balanced? #{BST.balanced?}"
BST.level_order do |item|
  puts "level order #{item}"
end
BST.preorder do |item|
  puts "preorder #{item}"
end
BST.inorder do |item|
  puts "inorder #{item}"
end
BST.postorder do |item|
  puts "postorder #{item}"
end
BST.insert(101)
BST.insert(110)
BST.insert(500)
BST.pretty_print
puts "Is tree balanced? #{BST.balanced?}"
BST.rebalance
puts 'Balancing...'
puts "Is tree balanced? #{BST.balanced?}"
BST.level_order do |item|
  puts "level order #{item}"
end
BST.preorder do |item|
  puts "preorder #{item}"
end
BST.inorder do |item|
  puts "inorder #{item}"
end
BST.postorder do |item|
  puts "postorder #{item}"
end
