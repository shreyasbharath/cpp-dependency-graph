# frozen_string_literal: true

require 'json'

class ComponentLink
  def initialize(source, target, cyclic = false)
    @source = source
    @target = target
    @cyclic = cyclic
  end

  def source
    @source
  end

  def target
    @target
  end

  def cyclic?
    @cyclic
  end

  def to_s
    if cyclic?
      "#{source} <-> #{target}"
    else
      "#{source} -> #{target}"
    end
  end

  def to_json(*a)
    { json_class: self.class.name,
      source: source, target: target, cyclic: cyclic?
    }.to_json(*a)
  end
end
