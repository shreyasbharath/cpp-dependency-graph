# frozen_string_literal: true

require_relative "cyclic_link"
require_relative "logging"

# Detects cycles between nodes
class CycleDetector
  include Logging

  def initialize(links)
    logger.debug "Resolving cyclic dependendencies..."
    @cyclic_links = links.flat_map do |source, source_links|
      logger.debug "#{source}, #{source_links}"
      source_links.select { |target| links.fetch(target, []).include?(source) }.map do |target|
        [CyclicLink.new(source, target), true]
      end
    end.to_h
  end

  def cyclic?(source, target)
    k = CyclicLink.new(source, target)
    @cyclic_links.key?(k)
  end

  def to_s
    @cyclic_links.keys
  end
end
