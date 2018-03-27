# frozen_string_literal: true

require_relative 'cpp_dependency_graph/project'
require_relative 'cpp_dependency_graph/dependency_graph'
require_relative 'cpp_dependency_graph/graph_visualiser'

# Generates dependency graphs of a project in various output forms
module CppDependencyGraph
  def generate_project_graph(project_dir, output_file)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    deps = graph.all_component_links
    GraphVisualiser.generate_dot_file(deps, output_file)
  end

  def generate_component_graph(project_dir, component, output_file)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    deps = graph.component_links(component)
    GraphVisualiser.generate_dot_file(deps, output_file)
  end

  def generate_component_class_graph(project_dir, component, output_file)
    project = Project.new(project_dir)

    # TODO: This logic does not belong here
    source_component = project.source_component(component)
    source_files = source_component.source_files
    deps = {}
    source_files.each do |file|
      internal_includes = file.includes.reject { |include| source_component.external_includes.any?(include) }
      deps[file.basename] = ComponentLink.new(file.basename, internal_includes)
    end
    GraphVisualiser.generate_dot_file(deps, output_file)
  end
end
