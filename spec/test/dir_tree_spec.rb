# frozen_string_literal: true

require 'json'

require 'cpp_dependency_graph/dir_tree'

RSpec.describe DirTree do
  let(:dir_tree) { DirTree.new('spec/test/example_project') }

  it 'returns empty tree an unknwon directory' do
    expect(DirTree.new('asdsadklasd').tree.empty?).to eq(true)
  end

  it 'returns all directories and its subdirectories as a tree hash structure' do
    expected_tree = JSON.parse('{
      "name": "spec/test/example_project",
      "children": [{
        "name": "DataAccess",
        "children": []
      }, {
        "name": "Engine",
        "children": []
      }, {
        "name": "Framework",
        "children": []
      }, {
        "name": "main",
        "children": []
      }, {
        "name": "System",
        "children": []
      }, {
        "name": "UI",
        "children": []
      }]
    }',
                               symbolize_names: true)
    # expect(dir_tree.tree).to eq(expected_tree)
  end
end
