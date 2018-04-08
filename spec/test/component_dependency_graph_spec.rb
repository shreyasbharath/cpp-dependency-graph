# frozen_string_literal: true

require 'cpp_dependency_graph/component_dependency_graph'
require 'cpp_dependency_graph/link'

RSpec.describe ComponentDependencyGraph do
  let(:project) { Project.new('spec/test/example_project') }
  let(:dependency_graph) { ComponentDependencyGraph.new(project) }

  it 'returns all links for a project' do
    expected_links = {}
    expected_links['UI'] = [Link.new('UI', 'Framework', false),
                            Link.new('UI', 'Engine', true)]
    expected_links['DataAccess'] = [Link.new('DataAccess', 'Framework', false)]
    expected_links['main'] = [Link.new('main', 'UI', false)]
    expected_links['Framework'] = []
    expected_links['System'] = []
    expected_links['Engine'] = [Link.new('Engine', 'Framework', false),
                                Link.new('Engine', 'UI', true),
                                Link.new('Engine', 'DataAccess', false)]
    expect(dependency_graph.all_links).to eq(expected_links)
  end

  it 'returns empty links for an unknown component of a project' do
    expect(dependency_graph.links('Blah').empty?).to eq(true)
  end

  it 'returns links for a specified component of a project' do
    expected_links = {}
    expected_links['UI'] = [Link.new('UI', 'Engine', true)]
    expected_links['Engine'] = [Link.new('Engine', 'Framework', false),
                                Link.new('Engine', 'UI', true),
                                Link.new('Engine', 'DataAccess', false)]
    expect(dependency_graph.links('Engine')).to eq(expected_links)
  end

  it 'returns all cyclic links of a project' do
    expected_links = {}
    expected_links['Engine'] = [Link.new('Engine', 'UI', true)]
    expected_links['UI'] = [Link.new('UI', 'Engine', true)]
    expect(dependency_graph.all_cyclic_links).to eq(expected_links)
  end
end
