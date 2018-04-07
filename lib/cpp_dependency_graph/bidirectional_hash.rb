# frozen_string_literal: true

# Hash that allows lookup by key and value
class BidirectionalHash
  def initialize
    @forward = Hash.new { |h, k| h[k] = [] }
    @reverse = Hash.new { |h, k| h[k] = [] }
  end

  def insert(key, value)
    @forward[key].push(value)
    @reverse[value].push(key)
    value
  end

  def fetch(key)
    fetch_from(@forward, key)
  end

  def rfetch(value)
    fetch_from(@reverse, value)
  end

  protected

  def fetch_from(hash, key)
    return nil unless hash.key?(key)
    v = hash[key]
    v.length == 1 ? v.first : v.dup
  end
end
