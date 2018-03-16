# frozen_string_literal: true

# TODO Use ruby-graphviz gem instead

DOT_FILE_HEADER =
<<~HEREDOC
digraph {
HEREDOC

DOT_FILE_FOOTER = '}'.freeze

class GraphToDotConverter
  def self.generate(graph, file)
    text = ''
    graph.each do |node, edges|
      edges.each do |edge|
        text += %Q|"#{node}" -> "#{edge}"\n|
      end
    end
    File.write(file, DOT_FILE_HEADER + text + DOT_FILE_FOOTER)
  end
end
