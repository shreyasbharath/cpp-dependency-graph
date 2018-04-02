# frozen_string_literal: true

class BidirectionalHash
  def initialize
    @forward = Hash.new { |h, k| h[k] = [ ] }
    @reverse = Hash.new { |h, k| h[k] = [ ] }
  end

  def insert(k, v)
    @forward[k].push(v)
    @reverse[v].push(k)
    v
  end

  def fetch(k)
    fetch_from(@forward, k)
  end

  def rfetch(v)
    fetch_from(@reverse, v)
  end

  protected

  def fetch_from(h, k)
    return nil if(!h.has_key?(k))
    v = h[k]
    v.length == 1 ? v.first : v.dup
  end
end
