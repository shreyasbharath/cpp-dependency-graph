# frozen_string_literal: true

require 'cpp_dependency_graph/dependency_graph'
require 'cpp_dependency_graph/component_link'

RSpec.describe DependencyGraph do
  let(:project) { Project.new('spec/test/example_project') }
  let(:dependency_graph) { DependencyGraph.new(project) }

  it 'returns all links for a project' do
    expected_links = {}
    expected_links['UI'] = [ComponentLink.new('UI', 'Framework', false),
                            ComponentLink.new('UI', 'Engine', true)]
    expected_links['DataAccess'] = [ComponentLink.new('DataAccess', 'Framework', false)]
    expected_links['main'] = [ComponentLink.new('main', 'UI', false)]
    expected_links['Framework'] = []
    expected_links['System'] = []
    expected_links['Engine'] = [ComponentLink.new('Engine', 'Framework', false),
                                ComponentLink.new('Engine', 'UI', true),
                                ComponentLink.new('Engine', 'DataAccess', false)]
    expect(dependency_graph.all_component_links).to eq(expected_links)
  end

  it 'returns empty links for an unknown component of a project' do
    expect(dependency_graph.component_links('Blah').empty?).to eq(true)
  end

  it 'returns links for a specified component of a project' do
    expected_links = {}
    expected_links['UI'] = [ComponentLink.new('UI', 'Engine', true)]
    expected_links['Engine'] = [ComponentLink.new('Engine', 'Framework', false),
                                ComponentLink.new('Engine', 'UI', true),
                                ComponentLink.new('Engine', 'DataAccess', false)]
    expect(dependency_graph.component_links('Engine')).to eq(expected_links)
  end

  it 'returns all cyclic links of a project' do
    expected_links = {}
    expected_links['Engine'] = [ComponentLink.new('Engine', 'UI', true)]
    expected_links['UI'] = [ComponentLink.new('UI', 'Engine', true)]
    expect(dependency_graph.all_cyclic_links).to eq(expected_links)
  end
end
