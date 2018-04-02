# frozen_string_literal: true

# A special class designed to be used as a key in a hash
class CyclicLink
  def initialize(nodeA, nodeB)
    @nodeA = nodeA
    @nodeB = nodeB
  end

  def nodeA
    @nodeA
  end

  def nodeB
    @nodeB
  end

  def eql?(other)
    (@nodeA == other.nodeA && @nodeB == other.nodeB) ||
    (@nodeA == other.nodeB && @nodeB == other.nodeA)
  end

  def hash
    [@nodeA, @nodeB].to_set.hash
  end

  def to_s
    "#{nodeA} <-> #{nodeB}"
  end
end
