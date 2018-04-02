# frozen_string_literal: true

require 'find'

require_relative 'source_component'

# Parses all components of a project
class Project
  def initialize(path)
    @path = path
  end

  def source_components
    @source_components ||= build_source_components
  end

  def source_component(name)
    source_components.detect { |c| c.name == name }
  end

  def dependencies(component)
    component.external_includes.map { |include| component_for_include(include) }.reject(&:empty?).uniq
  end

  private

  def build_source_components
    dirs = fetch_all_dirs(@path)
    source_components = dirs.map { |dir| SourceComponent.new(dir) }
    # TODO: Dealing with source components with same dir name?
    source_components.reject { |c| c.source_files.size.zero? }
  end

  def component_for_include(include)
    header_file = source_files.find { |file| file.basename == include }
    parent_component(header_file)
  end

  def source_files
    @source_files ||= source_components.flat_map(&:source_files)
  end

  def parent_component(header_file)
    return '' if header_file.nil?
    files = source_files.select { |file| file.basename_no_extension == header_file.basename_no_extension }
    corresponding_files = files.reject { |file| file.basename == header_file.basename }
    return header_file.parent_component if corresponding_files.size == 0
    corresponding_files[0].parent_component
  end

  def fetch_all_dirs(source_dir)
    Find.find(source_dir).select { |e| File.directory?(e) }
  end
end
