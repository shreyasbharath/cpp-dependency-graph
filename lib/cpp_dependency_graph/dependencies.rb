# frozen_string_literal: true

class Dependencies
  def initialize(deps)
    @deps = deps
  end

  def as_array
    @deps
  end

  def include?(candidate)
    @deps.any? { |dep| candidate.casecmp(dep) == 0 }
  end
end
