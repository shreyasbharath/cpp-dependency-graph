# frozen_string_literal: true

require_relative 'source_component'

# Resolves a given include to a source component
class IncludeToComponentResolver
  def initialize(components)
    @components = components
    @component_external_include_cache = {}
    @component_include_map_cache = {}
  end

  def external_includes(component)
    unless @component_external_include_cache.key?(component)
      @component_external_include_cache[component] = external_includes_private(component)
    end
    @component_external_include_cache[component]
  end

  def component_for_include(include)
    return '' unless source_files.key?(include)
    @component_include_map_cache[include] = component_for_include_private(include) unless @component_include_map_cache.key?(include)
    @component_include_map_cache[include]
  end

  private

  def external_includes_private(component)
    include_components = component.includes.map { |inc| [inc, component_for_include(inc)] }.to_h
    external_include_components = include_components.delete_if { |_, c| c == component.name }
    external_include_components.keys
  end

  def component_for_include_private(include)
    header_file = source_files[include]
    implementation_files = implementation_files(header_file)
    return header_file.parent_component if implementation_files.empty?
    implementation_files[0].parent_component
  end

  def implementation_files(header_file)
    implementation_files = []
    source_files.each_value do |file|
      implementation_files.push(file) if file.basename_no_extension == header_file.basename_no_extension
    end
    implementation_files.reject! { |file| file.basename == header_file.basename }
  end

  def source_files
    @source_files ||= build_source_file_map
  end

  def build_source_file_map
    # TODO: SourceComponent should return a hash for source files which can be merged here
    source_files = @components.values.flat_map(&:source_files)
    source_files.map { |s| [s.basename, s] }.to_h
  end
end
