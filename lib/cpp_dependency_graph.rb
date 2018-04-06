# frozen_string_literal: true

require_relative 'cpp_dependency_graph/project'
require_relative 'cpp_dependency_graph/dependency_graph'
require_relative 'cpp_dependency_graph/include_dependency_graph'
require_relative 'cpp_dependency_graph/graph_visualiser'
require_relative 'cpp_dependency_graph/version'

# Generates dependency graphs of a project in various output forms
module CppDependencyGraph
  def generate_project_graph(project_dir, format, output_file)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    deps = graph.all_component_links
    generate_visualisation(deps, format, output_file)
  end

  def generate_component_graph(project_dir, component, format, output_file)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    deps = graph.component_links(component)
    generate_visualisation(deps, format, output_file)
  end

  def generate_component_include_graph(project_dir, component_name, format, output_file)
    project = Project.new(project_dir)
    graph = IncludeDependencyGraph.new(project)
    deps = graph.include_links(component_name)
    generate_visualisation(deps, format, output_file)
  end

  def generate_cyclic_dependencies(project_dir, format, file)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    deps = graph.all_cyclic_links
    generate_visualisation(deps, format, file)
  end

  def generate_visualisation(deps, format, file)
    case format
    when 'dot'
      GraphVisualiser.new.generate_dot_file(deps, file)
    when 'html'
      GraphVisualiser.new.generate_html_file(deps, file)
    when 'json'
      File.write(file, JSON.pretty_generate(deps))
    end
  end
end
