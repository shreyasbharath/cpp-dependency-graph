# frozen_string_literal: true

class Links
  def initialize(links)
    @links = links
  end

  def as_array
    @links
  end

  def include?(candidate)
    @links.any? { |link| candidate.casecmp(link) == 0 }
  end
end
