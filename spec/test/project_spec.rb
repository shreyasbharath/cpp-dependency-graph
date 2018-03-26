require 'cpp_dependency_graph/project'

RSpec.describe Project do
  it 'parses all source components' do
    component_names = Project.new('spec/test/example_project').source_components.map(&:name).sort
    expect(component_names).to eq(['DataAccess', 'Engine', 'Framework', 'System', 'UI', 'main'])
  end

  it 'returns specific component and is case insensitive' do
    component = Project.new('spec/test/example_project').source_component('enGine')
    expect(component.name).to eq('Engine')
  end

  it 'returns dependencies of component' do
    project = Project.new('spec/test/example_project')
    component = project.source_component('enGine')
    dependencies = project.dependencies(component)
    expect(dependencies).to include('Framework', 'UI', 'DataAccess')
  end
end
