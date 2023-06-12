# frozen_string_literal: true

# Represents a #include in a source file
class IncludeDependency
  def initialize(raw_include)
    @raw_include = raw_include
    p = Pathname.new(@raw_include)
    @dir_name = p.dirname
    @basename = p.basename.to_s
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

  attr_reader :basename
end
