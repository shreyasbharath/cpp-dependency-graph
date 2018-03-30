# frozen_string_literal: true

require_relative 'tsortable_hash'

# Returns a hash of component links
class CycleDetector
  def initialize(links)
    @links = links
  end

  def cyclic_links(component_link)
    # TODO Can use caching here
    component_link.links.select do |dep|
      deps_of_dep = @links[dep]
      deps_of_dep.links.include?(component.label)
    end
  end

  def self.print_cyclic_dependencies(links)
    links.each do |_, value|
      value.links.each do |dep|
        deps_of_dep = links[dep]
        puts "Cyclic #{value.label} <-> #{dep}" if deps_of_dep.links.include?(value.label)
      end
    end
  end

  private
end
