require 'cpp_dependency_graph/project'

RSpec.describe Project do
  it 'parses all source components' do
    component_names = Project.new('spec/test/example_project').source_components.values.map(&:name).sort
    expect(component_names).to eq(['DataAccess', 'Engine', 'Framework', 'System', 'UI', 'main'])
  end

  it 'returns null component if case does not match' do
    component = Project.new('spec/test/example_project').source_component('enGine')
    expect(component.name).to eq('NULL')
    expect(component.source_files.size).to eq(0)
  end

  it 'returns dependencies of component' do
    project = Project.new('spec/test/example_project')
    component = project.source_component('Engine')
    dependencies = project.dependencies(component)
    expect(dependencies).to include('Framework', 'UI', 'DataAccess')
  end
end
