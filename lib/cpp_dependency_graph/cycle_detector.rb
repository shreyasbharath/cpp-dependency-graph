# frozen_string_literal: true

require_relative 'cyclic_link'

# Detects cycles between components
class CycleDetector
  def initialize(component_links)
    @cyclic_links = {}
    component_links.each do |source, links|
                      links.each do |target|
                        links_of_target = component_links[target]
                        @cyclic_links[CyclicLink.new(source, target)] = true if links_of_target.include?(source)
                      end
                    end
  end

  def cyclic?(source, target)
    k = CyclicLink.new(source, target)
    @cyclic_links.key?(k)
  end

  def to_s
    @cyclic_links.each { |k, _| puts k }
  end
end
