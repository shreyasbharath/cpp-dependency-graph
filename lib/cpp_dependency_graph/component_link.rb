# frozen_string_literal: true

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
end
