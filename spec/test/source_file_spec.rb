# frozen_string_literal: true

require 'cpp_dependency_graph/source_file'

RSpec.describe SourceFile do
  it 'has a path attribute that matches the path of the file' do
    source_file = SourceFile.new('spec/test/example_project/Engine/Engine.cpp')
    expect(source_file.path).to eq('spec/test/example_project/Engine/Engine.cpp')
  end

  it 'has a basename attribute that matches the file basename' do
    source_file = SourceFile.new('spec/test/example_project/Engine/Engine.cpp')
    expect(source_file.basename).to eq('Engine.cpp')
  end

  it 'has a basename no extension attribute that matches the file basename without extension' do
    source_file = SourceFile.new('spec/test/example_project/Engine/Engine.cpp')
    expect(source_file.basename_no_extension).to eq('Engine')
  end

  it 'has a parent component attribute that matches the directory the file lives in' do
    source_file = SourceFile.new('spec/test/example_project/Engine/Engine.cpp')
    expect(source_file.parent_component).to eq('Engine')
  end

  it 'has an includes attribute that contains all includes' do
    source_file = SourceFile.new('spec/test/example_project/Engine/Engine.cpp')
    expect(source_file.includes).to eq(['DataAccess/DA.h', 'Engine.h'])
  end

  it 'has a loc (lines of code) attribute' do
    source_file = SourceFile.new('spec/test/example_project/Engine/Engine.cpp')
    expect(source_file.loc).to be > 0
  end

  it 'exists? returns true for a file that exists' do
    source_file = SourceFile.new('spec/test/example_project/Engine/Engine.cpp')
    expect(source_file.exists?).to be true
  end

  it 'exists? returns false for a file that does not exist' do
    source_file = SourceFile.new('spec/test/example_project/Engine/Engine2.cpp')
    expect(source_file.exists?).to be false
  end
end
