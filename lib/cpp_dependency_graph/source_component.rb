# frozen_string_literal: true

require 'find'
require_relative 'source_file'

class SourceComponent
  def initialize(path)
    @path = path
  end

  def name
    @name ||= File.basename(@path)
  end

  def source_files
    @source_files ||= parse_source_files('.{h,hpp,hxx,c,cpp,cxx,cc}')
  end

  def outgoing_includes
    @outgoing_includes ||= scan_outgoing_includes
  end

  def to_s
    "#{name} has files #{source_files}. outgoing #includes are #{outgoing_includes}"
  end

  private

  def scan_outgoing_includes
    # TODO: This is super inefficient, refactor it
    all_includes = source_files.flat_map(&:includes).uniq.map { |include| File.basename(include) }
    source_file_basenames = source_files.map(&:basename)
    all_includes.reject { |include| source_file_basenames.include?(include) }
  end

  def parse_source_files(extensions)
    path = File.join(@path, '**', File::SEPARATOR) + '*' + extensions
    files = Dir.glob(path).select { |e| File.file?(e) }
    files.map { |file| SourceFile.new(file) }
  end

  def fetch_all_dirs(source_dir)
    Find.find(source_dir).select { |e| File.directory?(e) }
  end
end
