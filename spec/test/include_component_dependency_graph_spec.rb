# frozen_string_literal: true

require 'cpp_dependency_graph/include_component_dependency_graph'
require 'cpp_dependency_graph/link'

RSpec.describe IncludeComponentDependencyGraph do
  let(:project) { Project.new('spec/test/example_project') }
  let(:include_dependency_graph) { IncludeComponentDependencyGraph.new(project) }

  it 'returns empty hash for an unknown component' do
    expect(include_dependency_graph.links('Unknown').empty?).to eq(true)
  end

  it 'returns include links for a specified component' do
    expected_links = {}
    expected_links['OldEngine.h'] = []
    expected_links['Engine.h'] = [Link.new('Engine.h', 'Framework/framework.h', false),
                                  Link.new('Engine.h', 'UI/Display.h', false)]
    expected_links['Engine.cpp'] = [Link.new('Engine.cpp', 'DataAccess/DA.h', false),
                                    Link.new('Engine.cpp', 'Engine.h', false)]
    expect(include_dependency_graph.links('Engine')).to eq(expected_links)
  end
end
