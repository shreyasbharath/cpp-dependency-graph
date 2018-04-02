require 'cpp_dependency_graph/cyclic_link'

RSpec.describe CyclicLink do
  it 'returns equal for two objects with the same nodes' do
    expect(CyclicLink.new('nodeA', 'nodeB')).to eql(CyclicLink.new('nodeB', 'nodeA'))
  end

  it 'returns the same hash for two equivalent objects with the same nodes' do
    expect(CyclicLink.new('nodeA', 'nodeB').hash).to eq(CyclicLink.new('nodeB', 'nodeA').hash)
  end
end
