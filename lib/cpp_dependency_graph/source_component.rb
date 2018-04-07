# frozen_string_literal: true

require_relative 'source_file'

# Abstracts a source directory containing source files
class SourceComponent
  attr_reader :path

  def initialize(path)
    @path = path
  end

  def name
    @name ||= File.basename(@path)
  end

  def source_files
    @source_files ||= parse_source_files('.{h,hpp,hxx,c,cpp,cxx,cc}')
  end

  def includes
    @includes ||= source_files.flat_map(&:includes).uniq.map { |include| File.basename(include) }
  end

  def loc
    @loc ||= source_files.inject(0) { |total_loc, file| total_loc + file.loc }
  end

  private

  def parse_source_files(extensions)
    path = File.join(@path, File::SEPARATOR) + '*' + extensions
    Dir.glob(path).map { |e| SourceFile.new(e) if File.file?(e) }.compact
  end
end
