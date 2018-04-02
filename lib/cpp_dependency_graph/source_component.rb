# frozen_string_literal: true

require_relative 'source_file'

class SourceComponent
  def initialize(path)
    @path = path
  end

  def path
    @path
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
    files = Dir.glob(path).select { |e| File.file?(e) }
    files.map { |file| SourceFile.new(file) }
  end
end
