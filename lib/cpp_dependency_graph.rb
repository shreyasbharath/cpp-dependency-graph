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
    GraphVisualiser.new.generate_dot_file(deps, output_file)
  end

  def generate_component_graph(project_dir, component, output_file)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    deps = graph.component_links(component)
    GraphVisualiser.new.generate_dot_file(deps, output_file)
    # GraphVisualiser.new.generate_html_file(deps, output_file)
  end

  def generate_component_class_graph(project_dir, component, output_file)
    project = Project.new(project_dir)

    # TODO: This logic does not belong here
    source_component = project.source_component(component)
    source_files = source_component.source_files
    deps = {}
    source_files.each do |file|
      class_name = file.basename
      internal_includes = file.includes.reject { |inc| source_component.external_includes.any?(inc) }
      deps[class_name] = internal_includes.map { |inc| ComponentLink.new(class_name, inc, false) }
    end
    GraphVisualiser.new.generate_dot_file(deps, output_file)
  end
end
