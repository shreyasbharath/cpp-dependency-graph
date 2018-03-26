# frozen_string_literal: true

require_relative 'tsortable_hash'

# Returns a hash of component links
class CycleDetector
  def initialize(deps)
    @deps = deps
  end

  def cyclic
  end

  private
end
