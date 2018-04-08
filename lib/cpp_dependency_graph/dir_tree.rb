# frozen_string_literal: true

require 'json'

# Returns a root directory as a tree of directories
class DirTree
  attr_reader :tree

  def initialize(path)
    @tree ||= File.directory?(path) ? parse_dirs(path) : {}
  end

  private

  def parse_dirs(path, name = nil)
    data = {}
    data[:name] = (name || path)
    data[:children] = children = []
    # TODO: Use Dir.map.compact|filter instead here
    Dir.foreach(path) do |entry|
      next if ['..', '.'].include?(entry)
      full_path = File.join(path, entry)
      next unless File.directory?(full_path)
      children << parse_dirs(full_path, entry)
    end
    data
  end

  def to_s
    @tree.to_json
  end
end
