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
        connection = nodes[source].connect(nodes[link.target])
        connection.attributes[:color] = 'red' if link.cyclic?
      end
    end

    File.write(file, @g.to_dot)
    # Graphviz::output(g, path: 'file') # TODO: https://github.com/ioquatix/graphviz/issues/7
  end

  def generate_html_file(deps, file)
    node_names = deps.flat_map do |_, links|
                   links.map { |link| [link.source, link.target] }.flatten
                 end.uniq
    nodes = node_names.map { |name| { name: name } }

    connections = deps.flat_map do |_, links|
                    links.map do |link|
                      { source: link.source, dest: link.target }
                    end
                  end

    json_nodes = JSON.pretty_generate(nodes)
    json_connections = JSON.pretty_generate(connections)
    # File.write(file, json_nodes + json_connections)

    template = File.read('views/index.html.template')
    contents = template % { dependency_links: json_connections }
    File.write(file, contents)
  end

  private

  def create_node(name)
    node = @g.add_node(name)
    node.attributes[:shape] = 'box3d'
    node
  end
end
