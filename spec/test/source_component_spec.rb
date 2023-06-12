# frozen_string_literal: true

require 'cpp_dependency_graph/source_component'

RSpec.describe SourceComponent do
  it 'exists? returns true for a valid component' do
    component = SourceComponent.new('spec/test/example_project/Engine')
    expect(component.exists?).to be true
  end

  it 'exists? returns false for a valid component' do
    component = SourceComponent.new('spec/test/example_project/Engine2')
    expect(component.exists?).to be false
  end

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
    expect(source_file_names).to contain_exactly('Engine.cpp', 'Engine.h', 'OldEngine.h')
  end

  it 'has an includes attribute' do
    component = SourceComponent.new('spec/test/example_project/Engine')
    expect(component.includes).to contain_exactly('framework.h', 'Display.h', 'DA.h', 'Engine.h')
  end

  it 'has a loc (lines of code) attribute' do
    component = SourceComponent.new('spec/test/example_project/Engine')
    expect(component.loc).to be > 0
  end
end
