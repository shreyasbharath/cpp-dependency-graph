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
end
