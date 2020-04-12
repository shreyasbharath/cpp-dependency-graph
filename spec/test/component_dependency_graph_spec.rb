# frozen_string_literal: true

require 'cpp_dependency_graph/component_dependency_graph'
require 'cpp_dependency_graph/link'

RSpec.describe ComponentDependencyGraph do
  let(:project) { Project.new('spec/test/example_project') }
  let(:dependency_graph) { ComponentDependencyGraph.new(project) }

  it 'returns all links for a project' do
    links = dependency_graph.all_links
    expect(links['UI']).to contain_exactly(Link.new('UI', 'Engine', true), Link.new('UI', 'Framework', false))
    expect(links['DataAccess']).to contain_exactly(Link.new('DataAccess', 'Framework', false))
    expect(links['main']).to contain_exactly(Link.new('main', 'UI', false))
    expect(links['Framework']).to be_empty
    expect(links['System']).to be_empty
    expect(links['Engine']).to contain_exactly(Link.new('Engine', 'DataAccess', false), Link.new('Engine', 'Framework', false),
                                             Link.new('Engine', 'UI', true))
  end

  it 'returns empty links for an unknown component of a project' do
    expect(dependency_graph.links('Blah').empty?).to eq(true)
  end

  it 'returns links for a specified component of a project' do
    links = dependency_graph.links('Engine')
    expect(links['Engine']).to contain_exactly(Link.new('Engine', 'DataAccess', false), Link.new('Engine', 'Framework', false),
                                               Link.new('Engine', 'UI', true))
    expect(links['UI']).to contain_exactly(Link.new('UI', 'Engine', true))
  end

  it 'returns all cyclic links of a project' do
    links = dependency_graph.all_cyclic_links
    expect(links['Engine']).to contain_exactly(Link.new('Engine', 'UI', true))
    expect(links['UI']).to contain_exactly(Link.new('UI', 'Engine', true))
  end
end
