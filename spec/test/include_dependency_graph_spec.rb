# frozen_string_literal: true

require 'cpp_dependency_graph/include_dependency_graph'
require 'cpp_dependency_graph/link'

RSpec.describe IncludeDependencyGraph do
  let(:project) { Project.new('spec/test/example_project') }
  let(:include_dependency_graph) { IncludeDependencyGraph.new(project) }

  it 'returns empty hash for an unknown component' do
    expect(include_dependency_graph.component_links('Unknown').empty?).to eq(true)
  end

  it 'returns include links for a specified component' do
    expected_links = {}
    expected_links['OldEngine.h'] = []
    expected_links['Engine.h'] = [Link.new('Engine.h', 'Framework/framework.h', false),
                                  Link.new('Engine.h', 'UI/Display.h', false)]
    expected_links['Engine.cpp'] = [Link.new('Engine.cpp', 'DataAccess/DA.h', false),
                                    Link.new('Engine.cpp', 'Engine.h', false)]
    expect(include_dependency_graph.component_links('Engine')).to eq(expected_links)
  end

  it 'returns empty hash for an unknown file' do
    expect(include_dependency_graph.file_links('Unknown').empty?).to eq(true)
  end

  it 'returns include links for a specified file' do
    expected_links = {}
    expected_links['Engine.h'] = [Link.new('Engine.h', 'Engine.cpp', false),
                                  Link.new('Engine.h', 'Display.cpp', false),
                                  Link.new('Engine.h', 'Display.h', false)]
    expect(include_dependency_graph.file_links('Engine.h')).to eq(expected_links)
  end
end
