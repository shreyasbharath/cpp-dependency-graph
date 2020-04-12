# frozen_string_literal: true

# Source file and metadata
class SourceFile
  def initialize(file)
    @path = file
  end

  def basename
    @basename ||= File.basename(@path)
  end

  def basename_no_extension
    @basename_no_extension ||= File.basename(@path, File.extname(@path))
  end

  def path
    @path ||= File.absolute_path(@path)
  end

  def header?
    false # TODO: Implement check extension
  end

  def parent_component
    @parent_component ||= File.dirname(@path).split('/').last
  end

  def includes
    @includes ||= all_includes
  end

  def loc
    @loc ||= file_contents.lines.count
  end

  private

  def all_includes
    @all_includes ||= scan_includes
  end

  def scan_includes
    includes = file_contents.scan(/#include ["|<](.+)["|>]/) # TODO: use compiler lib to scan includes? llvm/clang?
    includes.uniq!
    includes.flatten
  end

  def file_contents
    @file_contents ||= sanitised_file_contents
  end

  def sanitised_file_contents
    contents = File.read(@path)
    return contents if contents.valid_encoding?

    contents.encode('UTF-16be', invalid: :replace, replace: '?').encode('UTF-8')
  end
end
