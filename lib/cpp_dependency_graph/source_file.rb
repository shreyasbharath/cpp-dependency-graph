# frozen_string_literal: true

require 'pathname'

# Source file and metadata
class SourceFile
  def initialize(file)
    @path = file
  end

  def basename
    @basename ||= File.basename(@path)
  end

  def path
    @path ||= File.absolute_path(@path)
  end

  def parent_component
    @parent_component ||= File.dirname(@path).split('/').last
  end

  def includes
    @includes ||= filter_self_includes(all_includes)
  end

  def num_includes
    @num_includes ||= includes.size
  end

  def loc
    @loc ||= file_contents.lines.count
  end

  private

  def all_includes
    @all_includes ||= scan_includes
  end

  def filter_self_includes(includes)
    includes.reject { |include| Pathname(include).sub_ext('') == Pathname(basename).sub_ext('') }
  end

  def scan_includes
    file_contents.scan(/#include "([^"]+)"/).uniq.flatten
  end

  def file_contents
    @file_contents ||= File.read(@path)
  end
end
