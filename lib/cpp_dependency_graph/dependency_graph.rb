# frozen_string_literal: true

require_relative 'project'
require_relative 'tsortable_hash'

# Returns a hash of component dependencies
class DependencyGraph
  def initialize(project)
    @project = project
  end

  def component_dependencies
    @component_dependencies ||= scan_component_dependencies
  end

  private

  def scan_component_dependencies
    dependencies = TsortableHash.new
    @project.source_components.each do |component|
      dependencies[component.name] = scan_dependencies(component).reject(&:empty?)
    end
    puts dependencies
    dependencies
    # dependencies.tsort      # Topological sort, does not wok with cyclic dependencies (throws an exception)
  end

  def scan_dependencies(component)
    component.outgoing_includes.map { |include| component_for_include(include) }.uniq
  end

  def component_for_include(include)
    source_file = @project.source_files.find { |file| file.basename == include }
    return source_file.parent_component unless source_file.nil?
    ''
  end
end
