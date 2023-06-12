# frozen_string_literal: true

require 'cpp_dependency_graph/include_dependency'

RSpec.describe IncludeDependency do
  it 'relative? returns false for an absolute include' do
    i = IncludeDependency.new('spec/test/example_project', 'Engine.h')
    expect(i.relative?).to be false
    expect(i.absolute?).to be true
  end

  it 'relative? returns true for a relative include' do
    i = IncludeDependency.new('spec/test/example_project', 'Engine/Engine.h')
    expect(i.relative?).to be true
    expect(i.absolute?).to be false
  end

  it 'component returns empty for a relative include' do
    i = IncludeDependency.new('spec/test/example_project', 'Engine.h')
    expect(i.component).to eq('')
  end

  it 'component returns parent directory for a relative include' do
    i = IncludeDependency.new('spec/test/example_project', 'Engine/Engine.h')
    expect(i.component).to eq('Engine')
  end
end
