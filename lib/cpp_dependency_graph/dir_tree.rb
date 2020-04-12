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
      next unless source_files_present?(full_path)
      data[:children] << parse_dirs(full_path, entry)
    end
    data
  end

  def source_files_present?(full_path)
    files = Dir.glob(File.join(full_path, File.join('**', '*' + source_file_extensions)))
    files.size.positive?
  end

  def to_s
    @tree.to_json
  end
end
