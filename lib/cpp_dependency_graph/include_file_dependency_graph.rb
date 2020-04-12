# frozen_string_literal: true

require_relative 'project'
require_relative 'link'
require_relative 'cycle_detector'

require 'pp'

# Returns a hash of individual file include links
class IncludeFileDependencyGraph
  def initialize(project)
    @project = project
  end

  def all_links
    # TODO: Implement
    {}
  end

  def all_cyclic_links
    # TODO: Implement
  end

  def links(file_name)
    components = @project.source_components
    all_source_files = components.values.flat_map(&:source_files)
    files = all_source_files.select do |file|
      file.includes.include?(file_name)
    end
    files.map do |file|
      links = [Link.new(file.basename, file_name, false)]
      [file.basename, links]
    end.to_h
  end
end
