# frozen_string_literal: true

# Represents a #include in a source file
class IncludeDependency
  def initialize(project_root_dir, raw_include)
    @project_root_dir = project_root_dir
    @raw_include = raw_include
  end

  def exists?
    full_path = File.join(@project_root_dir, @raw_include)
    puts full_path
    File.exist?(full_path)
  end
end
