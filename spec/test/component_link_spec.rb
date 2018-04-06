require 'cpp_dependency_graph/component_link'

RSpec.describe ComponentLink do
  it 'returns correct source attribute' do
    expect(ComponentLink.new('source', 'target').source).to eq('source')
  end

  it 'returns correct target attribute' do
    expect(ComponentLink.new('source', 'target').target).to eq('target')
  end

  it 'returns default cyclic? attribute as false' do
    expect(ComponentLink.new('source', 'target').cyclic?).to eq(false)
  end

  it 'returns correct cyclic? attribute' do
    expect(ComponentLink.new('source', 'target', true).cyclic?).to eq(true)
  end

  it 'returns equal if another instance has same attributes' do
    c1 = ComponentLink.new('source', 'target', true)
    c2 = ComponentLink.new('target', 'source', true)
    expect(c1). to eq(c2)
  end

  it 'returns not equal if another instance has different attributes' do
    c1 = ComponentLink.new('source1', 'target1', true)
    c2 = ComponentLink.new('source2', 'target2', true)
    expect(c1).to_not eq(c2)
  end
end
