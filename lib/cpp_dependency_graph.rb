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
        edge = OpenStruct.new
        edge.source = value.label
        edge.target = dep
        edge
      end
    end
    GraphVisualiser.generate_dot_file(deps.keys, links, output_file)
  end

  def generate_component_graph(project_dir, component, output_file)
    project = Project.new(project_dir)
    graph = DependencyGraph.new(project)
    deps = graph.component_links(component)
    links = deps.flat_map do |node, value|
      value.links.map do |dep|
        edge = OpenStruct.new
        edge.source = value.label
        edge.target = dep
        edge
      end
    end
    nodes = deps.values.map(&:label)
    GraphVisualiser.generate_dot_file(nodes, links, output_file)
  end

  def generate_component_class_graph(project_dir, component, output_file)
    project = Project.new(project_dir)
    source_component = project.source_component(component)
    source_files = source_component.source_files
    nodes = source_files.map(&:basename)
    links = source_files.flat_map do |file|
      file.includes.map do |include|
        edge = OpenStruct.new
        edge.source = file.basename
        edge.target = include
        edge
      end
    end
    links.reject! do |link|
      source_component.external_includes.any?(link.target)
    end
    GraphVisualiser.generate_dot_file(nodes, links, output_file)
  end
end
