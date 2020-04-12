# frozen_string_literal: true

require 'cpp_dependency_graph/include_file_dependency_graph'
require 'cpp_dependency_graph/link'

RSpec.describe IncludeFileDependencyGraph do
  let(:project) { Project.new('spec/test/example_project') }
  let(:include_dependency_graph) { IncludeFileDependencyGraph.new(project) }

  it 'returns empty hash for an unknown file' do
    expect(include_dependency_graph.links('Unknown').empty?).to eq(true)
  end

  it 'returns include links for a specified file' do
    expected_links = {}
    expected_links['Display.cpp'] = [Link.new('Display.cpp', 'Engine.h', false)]
    # expected_links['Display.h'] = [Link.new('Display.h', 'Engine.h', false)]
    expected_links['Engine.cpp'] = [Link.new('Engine.cpp', 'Engine.h', false)]
    expect(include_dependency_graph.links('Engine.h')).to eq(expected_links)
  end
end
