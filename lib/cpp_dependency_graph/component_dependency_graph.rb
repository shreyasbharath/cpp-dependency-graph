# frozen_string_literal: true

require_relative 'project'
require_relative 'link'
require_relative 'cycle_detector'

# Dependency tree/graph of entire project
class ComponentDependencyGraph
  def initialize(project)
    @project = project
  end

  def all_links
    @all_links ||= build_hash_links
  end

  def all_cyclic_links
    @all_cyclic_links ||= build_cyclic_links
  end

  def links(name)
    return {} unless all_links.key?(name)

    links = incoming_links(name)
    links.merge!(outgoing_links(name))
    links
  end

  private

  def build_hash_links
    raw_links = @project.source_components.values.map { |c| [c.name, @project.dependencies(c) || [] ] }.to_h
    @cycle_detector ||= CycleDetector.new(raw_links)
    links = raw_links.map do |source, source_links|
      c_links = source_links.map { |target| Link.new(source, target, @cycle_detector.cyclic?(source, target)) }
      [source, c_links]
    end.to_h
    links
  end

  def build_cyclic_links
    cyclic_links = all_links.select { |_, links| links.any?(&:cyclic?) }
    cyclic_links.each_value { |links| links.select!(&:cyclic?) }
  end

  def outgoing_links(name)
    all_links.slice(name)
  end

  def incoming_links(target)
    incoming_c_links = all_links.select { |_, c_links| c_links.any? { |link| link.target == target } }
    incoming_c_links.map do |source, _|
      link = Link.new(source, target, @cycle_detector.cyclic?(source, target))
      [source, [link]]
    end.to_h
  end
end
