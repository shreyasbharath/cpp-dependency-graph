require 'cpp_dependency_graph/source_component'

RSpec.describe SourceComponent do
  it 'has a name attribute that matches the directory' do
    component = SourceComponent.new('spec/test/example_project/Engine')
    expect(component.name).to eq('Engine')
  end

  it 'has a path attribute that matches the directory' do
    component = SourceComponent.new('spec/test/example_project/Engine')
    expect(component.path).to eq('spec/test/example_project/Engine')
  end

  it 'parses all source files within it' do
    source_file_names = SourceComponent.new('spec/test/example_project/Engine').source_files.map(&:basename)
    expect(source_file_names).to eq(['Engine.h', 'OldEngine.h', 'Engine.cpp'])
  end

  it 'has an includes attribute' do
    component = SourceComponent.new('spec/test/example_project/Engine')
    expect(component.includes).to eq(['framework.h', 'Display.h', 'DA.h', 'Engine.h'])
  end

  it 'has a loc (lines of code) attribute' do
    component = SourceComponent.new('spec/test/example_project/Engine')
    expect(component.loc).to be > 0
  end
end
