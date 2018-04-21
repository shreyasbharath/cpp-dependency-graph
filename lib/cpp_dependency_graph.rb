# frozen_string_literal: true

require_relative 'cpp_dependency_graph/circle_packing_visualiser'
require_relative 'cpp_dependency_graph/component_dependency_graph'
require_relative 'cpp_dependency_graph/dir_tree'
require_relative 'cpp_dependency_graph/graph_to_dot_visualiser'
require_relative 'cpp_dependency_graph/graph_to_html_visualiser'
require_relative 'cpp_dependency_graph/include_dependency_graph'
require_relative 'cpp_dependency_graph/project'
require_relative 'cpp_dependency_graph/version'

# Generates dependency graphs of a project in various output forms
module CppDependencyGraph
  def generate_project_graph(project_dir, format, output_file)
    project = Project.new(project_dir)
    graph = ComponentDependencyGraph.new(project)
    deps = graph.all_links
    generate_visualisation(deps, format, output_file)
  end

  def generate_component_graph(project_dir, component, format, output_file)
    project = Project.new(project_dir)
    graph = ComponentDependencyGraph.new(project)
    deps = graph.links(component)
    generate_visualisation(deps, format, output_file)
  end

  def generate_component_include_graph(project_dir, component_name, format, output_file)
    project = Project.new(project_dir)
    graph = IncludeDependencyGraph.new(project)
    deps = graph.links(component_name)
    generate_visualisation(deps, format, output_file)
  end

  def generate_project_include_graph(project_dir, format, output_file)
    project = Project.new(project_dir)
    graph = IncludeDependencyGraph.new(project)
    deps = graph.all_links
    generate_visualisation(deps, format, output_file)
  end

  def generate_enclosure_diagram(project_dir, output_file)
    dir_tree = DirTree.new(project_dir)
    tree = dir_tree.tree
    puts tree
    CirclePackingVisualiser.new.generate(tree, output_file)
  end

  def generate_cyclic_dependencies(project_dir, format, file)
    project = Project.new(project_dir)
    graph = ComponentDependencyGraph.new(project)
    deps = graph.all_cyclic_links
    generate_visualisation(deps, format, file)
  end

  def generate_visualisation(deps, format, file)
    case format
    when 'dot'
      GraphToDotVisualiser.new.generate(deps, file)
    when 'html'
      GraphToHtmlVisualiser.new.generate(deps, file)
    when 'json'
      File.write(file, JSON.pretty_generate(deps))
    end
  end
end
