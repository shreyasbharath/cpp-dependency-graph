# frozen_string_literal: true

require 'cpp_dependency_graph/include_dependency'

RSpec.describe IncludeDependency do
  it 'relative? returns false for an absolute include' do
    i = IncludeDependency.new('Engine.h')
    expect(i.relative?).to be false
    expect(i.absolute?).to be true
  end

  it 'relative? returns true for a relative include' do
    i = IncludeDependency.new('Engine/Engine.h')
    expect(i.relative?).to be true
    expect(i.absolute?).to be false
  end

  it 'component returns empty for a relative include' do
    i = IncludeDependency.new('Engine.h')
    expect(i.component).to eq('')
  end

  it 'component returns parent directory for a relative include' do
    i = IncludeDependency.new('Engine/Engine.h')
    expect(i.component).to eq('Engine')
  end

  it 'returns the correct basename' do
    i = IncludeDependency.new('Engine/Engine.h')
    expect(i.basename).to eq('Engine.h')
  end

  it 'compares correctly against other instances' do
    i1 = IncludeDependency.new('Engine/Engine.h')
    i2 = IncludeDependency.new('Engine/Engine.h')
    expect(i1).to eq(i2)
  end
end
