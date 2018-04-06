# frozen_string_literal: true

require_relative 'project'
require_relative 'component_link'
require_relative 'cycle_detector'

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

  def all_cyclic_links
    @cyclic_links ||= build_cyclic_links
  end

  def component_links(name)
    return {} unless all_component_links.key?(name)
    incoming_links(name).merge(outgoing_links(name))
  end

  private

  def build_hash_component_links
    raw_links = @project.source_components.map { |c| [c.name, @project.dependencies(c)] }.to_h
    cycle_detector = CycleDetector.new(raw_links)
    component_links = raw_links.map do |source, links|
                        c_links = links.map { |target| ComponentLink.new(source, target, cycle_detector.cyclic?(source, target)) }
                        [source, c_links]
                      end.to_h
    component_links
  end

  def build_cyclic_links
    cyclic_links = all_component_links.select { |_, links| links.any? { |link| link.cyclic? } }
    cyclic_links.each { |_, links| links.select! { |link| link.cyclic? } }
  end

  def outgoing_links(name)
    all_component_links.slice(name)
  end

  def incoming_links(target)
    incoming_c_links = all_component_links.select { |c, c_links| c_links.any? { |link| link.target == target } }
    incoming_c_links.map do |c_name, _|
      link = ComponentLink.new(c_name, target, false)
      [c_name, [link]]
    end.to_h
  end
end
