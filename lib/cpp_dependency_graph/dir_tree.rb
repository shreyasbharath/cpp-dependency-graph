# frozen_string_literal: true

require 'json'

require_relative 'config'

# Returns a root directory as a tree of directories
class DirTree
  include Config

  attr_reader :tree

  def initialize(path)
    @tree ||= File.directory?(path) ? parse_dirs(path) : {}
  end

  private

  def parse_dirs(path, name = nil)
    data = Hash.new { |h, k| h[k] = [] }
    data[:name] = (name || path)
    # TODO: Use Dir.map.compact|filter instead here
    Dir.foreach(path) do |entry|
      next if ['..', '.'].include?(entry)
      full_path = File.join(path, entry)
      next unless File.directory?(full_path)
      data[:files] = num_source_files(full_path)
      next unless data[:files].positive?
      data[:children] << parse_dirs(full_path, entry)
    end
    data
  end

  def num_source_files(full_path)
    files = Dir.glob(File.join(full_path, File.join('**', '*' + source_file_extensions)))
    files.size
  end

  def to_s
    @tree.to_json
  end
end
