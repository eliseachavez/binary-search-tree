# frozen_string_literal: true

# node class for Binary Search Tree
class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
  end
end