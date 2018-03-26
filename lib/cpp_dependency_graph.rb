# frozen_string_literal: true

require_relative 'cpp_dependency_graph/project'
require_relative 'cpp_dependency_graph/dependency_graph'
require_relative 'cpp_dependency_graph/graph_visualiser'

# Generate dependency graph of a project as a dot file
module CppDependencyGraph
  def generate_project_graph(project_dir, output_file)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    deps = graph.all_component_links
    links = deps.flat_map do |node, value|
      value.dependencies.map do |dep|
        temp = OpenStruct.new
        temp.source = value.label
        temp.target = dep
        temp
      end
    end
    GraphVisualiser.generate_dot_file(deps.keys, links, output_file)
  end

  def generate_component_graph(project_dir, component, output_file)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    deps = graph.component_links(component)
    links = deps.flat_map do |node, value|
      value.dependencies.map do |dep|
        temp = OpenStruct.new
        temp.source = value.label
        temp.target = dep
        temp
      end
    end
    GraphVisualiser.generate_dot_file(deps.keys, links, output_file)
  end

  def generate_component_class_graph(project_dir, component, output_file)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    # TODO: Implement
  end
end
