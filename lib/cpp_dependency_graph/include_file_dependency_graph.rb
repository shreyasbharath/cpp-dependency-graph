# frozen_string_literal: true

require_relative 'project'
require_relative 'link'
require_relative 'cycle_detector'

# Returns a hash of individual file include links
class IncludeFileDependencyGraph
  def initialize(project)
    @project = project
  end

  def all_cyclic_links
    # TODO: Implement
  end

  def links(file_name)
    files = @project.source_files.select do |_, file|
      file.includes.include?(file_name)
    end
    files.map do |_, file|
      links = [Link.new(file.basename, file_name, false)]
      [file.basename, links]
    end.to_h
  end
end
