# frozen_string_literal: true

require_relative 'project'
require_relative 'link'
require_relative 'cycle_detector'

# Returns a hash of intra-component include links
class IncludeDependencyGraph
  def initialize(project)
    @project = project
  end

  def all_links
    components = @project.source_components
    all_source_files = components.values.flat_map(&:source_files)
    all_source_files.map do |file|
      source = file.basename
      links = file.includes.map { |inc| Link.new(source, inc, false) }
      [source, links]
    end.to_h
  end

  def all_cyclic_links
    # TODO: Implement
  end

  def component_links(component_name)
    component = @project.source_component(component_name)
    source_files = component.source_files
    external_includes = @project.external_includes(component)
    source_files.map do |file|
      # TODO: Very inefficient
      source = file.basename
      internal_includes = file.includes.reject { |inc| external_includes.any?(inc) }
      links = internal_includes.map { |inc| Link.new(source, inc, false) }
      [source, links]
    end.to_h
  end

  def file_links(file_name)
    {}
  end
end
