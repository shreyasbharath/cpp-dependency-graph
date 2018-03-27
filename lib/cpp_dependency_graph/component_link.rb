# frozen_string_literal: true

class ComponentLink
  def initialize(label, links)
    @label = label
    @links = links
  end

  def label
    @label
  end

  def links
    @links
  end

  def to_s
    @links.to_a.to_s
  end
end
