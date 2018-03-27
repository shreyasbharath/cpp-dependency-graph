# frozen_string_literal: true

require 'graphviz'
require 'json'

class GraphVisualiser
  def self.generate_dot_file(deps, file)
    g = Graphviz::Graph.new(name = 'dependency_graph')

    nodes = {}
    deps.each do |_, value|
      node = g.add_node(value.label)
      node.attributes[:shape] = 'box3d'
      nodes[value.label] = node
      value.links.each do |other_node_name|
        other_node = g.add_node(other_node_name)
        other_node.attributes[:shape] = 'box3d'
        nodes[other_node_name] = other_node
      end
    end

    deps.each do |_, value|
      value.links.each do |other_node_name|
        nodes[value.label].connect(nodes[other_node_name])
      end
    end

    File.write(file, g.to_dot)
    # Graphviz::output(g, path: 'file') # TODO: https://github.com/ioquatix/graphviz/issues/7
  end

  def self.generate_html_file(nodes, links, file)
  end
end
