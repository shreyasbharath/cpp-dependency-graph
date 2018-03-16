# frozen_string_literal: true

require_relative 'source_component'

# Parses all top-level components of a project
class Project
  def initialize(path)
    @path = path
  end

  def source_components
    @source_components ||= build_source_components
  end

  def source_files
    @source_files ||= source_components.flat_map(&:source_files)
  end

  private

  def build_source_components
    dirs = fetch_immediate_sub_dirs(@path)
    dirs.map { |dir| SourceComponent.new(dir) }
  end

  def fetch_immediate_sub_dirs(source_dir)
    # TODO: Filter out components that don't have source files?
    Dir[File.join(source_dir, '*', File::SEPARATOR)]
  end
end
