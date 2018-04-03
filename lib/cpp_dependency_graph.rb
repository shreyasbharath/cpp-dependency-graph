# frozen_string_literal: true

require_relative 'cpp_dependency_graph/project'
require_relative 'cpp_dependency_graph/dependency_graph'
require_relative 'cpp_dependency_graph/include_dependency_graph'
require_relative 'cpp_dependency_graph/graph_visualiser'
require_relative 'cpp_dependency_graph/version'

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

  def generate_component_include_graph(project_dir, component_name, output_file)
    project = Project.new(project_dir)
    graph = IncludeDependencyGraph.new(project)
    deps = graph.include_links(component_name)
    GraphVisualiser.new.generate_dot_file(deps, output_file)
  end

  def output_cyclic_dependencies(project_dir)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    deps = graph.all_component_links
    cyclic_deps = deps.values.flatten.select { |dep| dep.cyclic? }
    puts JSON.pretty_generate(cyclic_deps)
  end
end
