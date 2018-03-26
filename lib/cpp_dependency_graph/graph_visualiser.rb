# frozen_string_literal: true

require 'json'

# TODO Use ruby-graphviz gem instead

DOT_FILE_HEADER =
<<~HEREDOC
digraph {
HEREDOC

DOT_FILE_FOOTER = '}'.freeze

class GraphVisualiser
  def self.generate_dot_file(nodes, links, file)
    node_attributes = nodes.map { |node| %Q|"#{node}" [shape=oval];\n| }.join('')
    relations = links.map { |link| %Q|"#{link.source}" -> "#{link.target}" [color=#{link_colour(link)}];\n| }.join('')
    File.write(file, DOT_FILE_HEADER + node_attributes + relations + DOT_FILE_FOOTER)
  end

  def self.generate_html_file(nodes, links, file)
  end

  private_class_method def self.link_colour(link)
    link.cyclic ? 'red' : 'blue'
  end
end
