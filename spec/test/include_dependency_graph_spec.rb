require 'cpp_dependency_graph/include_dependency_graph'
require 'cpp_dependency_graph/component_link'

RSpec.describe IncludeDependencyGraph do
  let(:project) { Project.new('spec/test/example_project') }
  let(:include_dependency_graph) { IncludeDependencyGraph.new(project) }

  it 'returns empty hash for an unknown component' do
    expect(include_dependency_graph.include_links('Unknown').empty?).to eq(true)
  end

  it 'returns include links for a specified component' do
    expected_links = {}
    expected_links['OldEngine.h'] = []
    expected_links['Engine.h'] = [ComponentLink.new('Engine.h', 'Framework/framework.h', false),
                                  ComponentLink.new('Engine.h', 'UI/Display.h', false)]
    expected_links['Engine.cpp'] = [ComponentLink.new('Engine.cpp', 'DataAccess/DA.h', false),
                                    ComponentLink.new('Engine.cpp', 'Engine.h', false)]
    expect(include_dependency_graph.include_links('Engine')).to eq(expected_links)
  end
end
