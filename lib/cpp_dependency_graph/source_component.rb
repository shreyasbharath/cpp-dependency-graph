# frozen_string_literal: true

require 'pathname'

require_relative 'config'
require_relative 'include_dependency'
require_relative 'directory_parser'
require_relative 'source_file'

# Abstracts a source directory containing source files
class SourceComponent
  include Config
  include DirectoryParser

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def name
    @name ||= File.basename(@path)
  end

  def source_files
    @source_files ||= parse_source_files(source_file_extensions)
  end

  def includes
    @includes ||= includes_private
  end

  def loc
    @loc ||= source_files.inject(0) { |total_loc, file| total_loc + file.loc }
  end

  def exists?
    File.exist?(@path)
  end

  private

  def parse_source_files(extensions)
    glob_files(@path, extensions).map { |e| SourceFile.new(e) }.compact
  end

  def includes_private
    raw_includes = source_files.flat_map(&:includes).uniq.map { |raw_include| raw_include }
    resolved_includes = raw_includes.select { |f| IncludeDependency.new(Pathname.new(@path).parent, f).exists? }
    resolved_includes.map { |i| File.basename(i) }
  end
end
