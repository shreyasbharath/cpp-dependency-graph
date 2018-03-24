# frozen_string_literal: true

require_relative 'project'
require_relative 'tsortable_hash'

# Returns a hash of component dependencies
class DependencyGraph
  def initialize(project)
    @project = project
  end

  def all_component_dependencies
    @overall_dependencies ||= scan_all_component_dependencies
  end

  def component_dependencies(name)
    incoming_depenencies(name).merge(outgoing_dependencies(name))
  end

  private

  def scan_all_component_dependencies
    dependencies = TsortableHash.new
    @project.source_components.each do |component|
      dependencies[component.name.downcase] = scan_dependencies(component).reject(&:empty?)
    end
    dependencies
    # dependencies.tsort      # Topological sort, does not work with cyclic dependencies (throws an exception)
  end

  def scan_dependencies(component)
    deps = component.outgoing_includes.map { |include| component_for_include(include) }
    Set.new(deps)
  end

  def outgoing_dependencies(name)
    return [] if all_component_dependencies[name].nil?
    all_component_dependencies.slice(name)
  end

  def incoming_depenencies(name)
    incoming_components = all_component_dependencies.select do |component, deps|
      deps.any? { |dep| dep.casecmp(name) == 0 }
    end
    incoming_components.keys.map { |dep| [dep, [name]] }.to_h
  end

  def component_for_include(include)
    source_file = @project.source_files.find { |file| file.basename == include }
    return source_file.parent_component unless source_file.nil?
    ''
  end
end
