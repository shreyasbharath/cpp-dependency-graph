# frozen_string_literal: true

require_relative 'project'
require_relative 'link'
require_relative 'cycle_detector'

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
    {}
  end
end
