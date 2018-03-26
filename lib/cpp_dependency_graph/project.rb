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
    source_components.detect { |c| c.name.downcase == name.downcase }
  end

  def dependencies(component)
    deps = component.external_includes.map { |include| component_for_include(include) }.reject(&:empty?)
    Set.new(deps)
  end

  private

  def build_source_components
    dirs = fetch_all_dirs(@path)
    source_components = dirs.map { |dir| SourceComponent.new(dir) }
    # TODO: Dealing with source components with same dir name?
    source_components.reject { |c| c.source_files.size.zero? }
  end

  def component_for_include(include)
    source_file = source_files.find { |file| file.basename == include }
    return source_file.parent_component unless source_file.nil?
    ''
  end

  def source_files
    @source_files ||= source_components.flat_map(&:source_files)
  end

  def fetch_all_dirs(source_dir)
    Find.find(source_dir).select { |e| File.directory?(e) }
  end
end
