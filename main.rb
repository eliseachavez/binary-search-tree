# frozen_string_literal: true

require_relative 'tree'
require_relative 'node'

unsorted_ary = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
BST = Tree.new(unsorted_ary)