# frozen_string_literal: true

require_relative 'project'
require_relative 'component_link'
require_relative 'cycle_detector'

# Returns a hash of intra-component include links
class IncludeDependencyGraph
  def initialize(project)
    @project = project
  end

  def include_links(component_name)
    component = @project.source_component(component_name)
    source_files = component.source_files
    source_files.map do |file|
      class_name = file.basename
      # TODO: Very inefficient
      internal_includes = file.includes.reject { |inc| @project.external_includes(component).any?(inc) }
      include_links = internal_includes.map { |inc| ComponentLink.new(class_name, inc, false) }
      [class_name, include_links]
    end.to_h
  end
end
