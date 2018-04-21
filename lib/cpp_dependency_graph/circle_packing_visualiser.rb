# frozen_string_literal: true

require 'json'

# Outputs a `d3 circle packing layout` equipped HTML representation of a hierarchical tree
class CirclePackingVisualiser
  def generate(tree, file)
    json_tree = JSON.pretty_generate(tree)
    template_file = resolve_file_path('views/circle_packing.html.template')
    template = File.read(template_file)
    contents = format(template, tree: json_tree)
    File.write(file, contents)
  end

  private

  def resolve_file_path(path)
    File.expand_path("../../../#{path}", __FILE__)
  end
end
