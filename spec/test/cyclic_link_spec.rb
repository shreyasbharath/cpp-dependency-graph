# frozen_string_literal: true

require 'cpp_dependency_graph/cyclic_link'

RSpec.describe CyclicLink do
  it 'returns equal for two objects with the same nodes' do
    expect(CyclicLink.new('nodeA', 'nodeB')).to eql(CyclicLink.new('nodeB', 'nodeA'))
  end

  it 'returns the same hash for two equivalent objects with the same nodes' do
    expect(CyclicLink.new('nodeA', 'nodeB').hash).to eq(CyclicLink.new('nodeB', 'nodeA').hash)
  end

  it 'implements eql? operator correctly for usage as a hash key' do
    h = {}
    c1 = CyclicLink.new('nodeA', 'nodeB')
    c2 = CyclicLink.new('nodeB', 'nodeA')
    h[c1] = true
    h[c2] = false
    expect(h[c1]).to eq(false)
  end
end
