# frozen_string_literal: true

require 'graphviz'
require 'json'

class GraphVisualiser
  def generate_dot_file(deps, file)
    @g = Graphviz::Graph.new(name = 'dependency_graph')

    node_names = deps.flat_map do |_, links|
                   links.map { |link| [link.source, link.target] }.flatten
                 end.uniq
    nodes = node_names.map { |name| [name, create_node(name)] }.to_h

    deps.each do |source, links|
      links.each do |link|
        nodes[source].connect(nodes[link.target])
      end
    end

    File.write(file, @g.to_dot)
    # Graphviz::output(g, path: 'file') # TODO: https://github.com/ioquatix/graphviz/issues/7
  end

  def generate_html_file(deps, file)
    nodes = []
    deps.each do |_, value|
      node = { name: value.label }
      nodes.append(node)
      value.links.each do |other_node_name|
        other_node = { name: other_node_name }
        nodes.append(other_node)
      end
    end
    nodes.uniq!
    puts JSON.pretty_generate(nodes)

    connections = []
    deps.each do |_, value|
      value.links.each do |other_node_name|
        connection = { source: value.label, target: other_node_name }
        connections.append(connection)
      end
    end

    puts JSON.pretty_generate(connections)
  end

  private

  def create_node(name)
    node = @g.add_node(name)
    node.attributes[:shape] = 'box3d'
    node
  end
end
