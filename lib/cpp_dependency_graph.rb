# frozen_string_literal: true

require_relative 'cpp_dependency_graph/project'
require_relative 'cpp_dependency_graph/dependency_graph'
require_relative 'cpp_dependency_graph/graph_visualiser'

# Generate dependency graph of a project as a dot file
module CppDependencyGraph
  def generate(args)
    project = Project.new(args.project_dir)
    graph = DependencyGraph.new(project)
    deps = args[:component].nil? ? graph.all_component_links : graph.component_links(args.component)
    links = deps.flat_map do |node, value|
              value.dependencies.map do |dep|
                temp = OpenStruct.new
                temp.source = value.label
                temp.target = dep
                temp
              end
            end
    GraphVisualiser.generate_dot_file(deps.keys, links, args.output_file)
  end
end
