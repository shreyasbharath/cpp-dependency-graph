# frozen_string_literal: true

require_relative 'cyclic_link'

# Detects cycles between components
class CycleDetector
  def initialize(component_links)
    @cyclic_links = component_links.flat_map do |source, links|
                      links.select { |target| component_links[target].include?(source) }.map do |target|
                        [CyclicLink.new(source, target), true]
                      end
                    end.to_h
  end

  def cyclic?(source, target)
    k = CyclicLink.new(source, target)
    @cyclic_links.key?(k)
  end

  def to_s
    @cyclic_links.keys
  end
end
