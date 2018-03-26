# frozen_string_literal: true

require_relative 'component_link'
require_relative 'project'

# Returns a hash of component links
class DependencyGraph
  def initialize(project)
    @project = project
  end

  def components
    @components ||= source_components
  end

  def all_component_links
    @all_component_links ||= build_hash_component_links
  end

  def component_links(name)
    return {} unless all_component_links.key?(name)
    component_label = all_component_links[name].label
    incoming_links(component_label).merge(outgoing_links(name))
  end

  private

  def build_hash_component_links
    component_links = @project.source_components.map do |component|
                        key = component.name.downcase
                        value = ComponentLink.new(component.name, @project.dependencies(component))
                        [key, value]
                      end.to_h
    component_links
  end

  def outgoing_links(name)
    all_component_links.slice(name)
  end

  def incoming_links(label)
    incoming_components = all_component_links.select do |component, value|
      value.links.any? { |dep| dep == label }
    end
    incoming_components.map do |component, dep|
      key = component
      value = ComponentLink.new(dep.label, [label])
      [key, value]
    end.to_h
  end
end
