# frozen_string_literal: true

require 'json'
require 'set'

# Represents a link between two entities, a source and a target
class Link
  attr_reader :source
  attr_reader :target

  def initialize(source, target, cyclic = false)
    @source = source
    @target = target
    @cyclic = cyclic
  end

  def cyclic?
    @cyclic
  end

  def ==(other)
    (source == other.source && target == other.target && cyclic? == other.cyclic?) ||
      (source == other.target && target == other.source && cyclic? == other.cyclic?)
  end

  def hash
    [source, target, cyclic?].to_set.hash
  end

  def to_s
    if cyclic?
      "#{source} <-> #{target}"
    else
      "#{source} -> #{target}"
    end
  end

  def to_json(*options)
    { json_class: self.class.name,
      source: source, target: target, cyclic: cyclic? }.to_json(*options)
  end
end
