# frozen_string_literal: true

# A special class designed to be used as a key in a hash
class CyclicLink
  attr_reader :node_a
  attr_reader :node_b

  def initialize(node_a, node_b)
    @node_a = node_a
    @node_b = node_b
  end

  def eql?(other)
    (@node_a == other.node_a && @node_b == other.node_b) ||
      (@node_a == other.node_b && @node_b == other.node_a)
  end

  def hash
    [@node_a, @node_b].to_set.hash
  end

  def to_s
    "#{node_a} <-> #{node_b}"
  end
end
