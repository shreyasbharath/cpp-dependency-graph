# frozen_string_literal: true

require 'cpp_dependency_graph/project'

RSpec.describe Project do
  it 'parses overall project component' do
    component_names = Project.new('spec/test/example_project').project_component.values.map(&:name)
    expect(component_names).to contain_exactly('example_project')
  end

  it 'parses all source components' do
    component_names = Project.new('spec/test/example_project').source_components.values.map(&:name)
    expect(component_names).to contain_exactly('DataAccess', 'Engine', 'Framework', 'System', 'UI', 'main')
  end

  it 'returns null component if case does not match' do
    component = Project.new('spec/test/example_project').source_component('enGine')
    expect(component.name).to eq('NULL')
    expect(component.source_files.size).to eq(0)
  end

  it 'returns null component if no such component exists' do
    component = Project.new('spec/test/example_project').source_component('Unknown')
    expect(component.name).to eq('NULL')
    expect(component.source_files.size).to eq(0)
  end

  it 'returns dependencies of component' do
    project = Project.new('spec/test/example_project')
    component = project.source_component('Engine')
    dependencies = project.dependencies(component)
    expect(dependencies).to include('Framework', 'UI', 'DataAccess')
  end

  it 'all source files of project' do
    project = Project.new('spec/test/example_project')
    source_files = project.source_files.values.map(&:basename)
    expect(source_files).to contain_exactly('DA.h', 'Display.cpp', 'Display.h', 'Engine.cpp', 'Engine.h', 'Engine.h',
                                            'OldEngine.h', 'System.cpp', 'System.h', 'framework.h', 'main.cpp')
  end
end
