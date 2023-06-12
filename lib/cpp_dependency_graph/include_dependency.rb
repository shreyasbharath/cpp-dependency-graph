# frozen_string_literal: true

# Represents a #include in a source file
class IncludeDependency
  def initialize(project_root_dir, raw_include)
    @project_root_dir = project_root_dir
    @raw_include = raw_include
    @dir_name = Pathname.new(@raw_include).dirname
    @absolute_include = @dir_name == Pathname.new('.')
  end

  def relative?
    !@absolute_include
  end

  def absolute?
    @absolute_include
  end

  def component
    return @dir_name.to_s unless absolute?

    ''
  end

  def exists?
    full_path = File.join(@project_root_dir, @raw_include)
    File.exist?(full_path)
  end
end
