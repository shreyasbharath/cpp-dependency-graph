# frozen_string_literal: true

require 'json'

# Outputs a `d3 force graph layout` equipped HTML representation of a dependency graph
class GraphToHtmlVisualiser
  def generate(deps, file)
    connections = deps.flat_map do |_, links|
      links.map do |link|
        { source: link.source, dest: link.target }
      end
    end
    json_connections = JSON.pretty_generate(connections)
    template_file = resolve_file_path('views/index.html.template')
    template = File.read(template_file)
    contents = format(template, dependency_links: json_connections)
    File.write(file, contents)
  end

  private

  def resolve_file_path(path)
    File.expand_path("../../../#{path}", __FILE__)
  end
end
