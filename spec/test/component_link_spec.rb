# frozen_string_literal: true

require 'cpp_dependency_graph/link'

RSpec.describe Link do
  it 'returns correct source attribute' do
    expect(Link.new('source', 'target').source).to eq('source')
  end

  it 'returns correct target attribute' do
    expect(Link.new('source', 'target').target).to eq('target')
  end

  it 'returns default cyclic? attribute as false' do
    expect(Link.new('source', 'target').cyclic?).to eq(false)
  end

  it 'returns correct cyclic? attribute' do
    expect(Link.new('source', 'target', true).cyclic?).to eq(true)
  end

  it 'returns equal if another instance has same attributes' do
    c1 = Link.new('source', 'target', true)
    c2 = Link.new('target', 'source', true)
    expect(c1). to eq(c2)
  end

  it 'returns not equal if another instance has different attributes' do
    c1 = Link.new('source1', 'target1', true)
    c2 = Link.new('source2', 'target2', true)
    expect(c1).to_not eq(c2)
  end
end
