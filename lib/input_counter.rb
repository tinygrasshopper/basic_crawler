class InputCounter
  attr_reader :links

  def initialize
    @links = {}
  end

  def increment link, count
    @links[link] = @links[link].to_i + count
    increment(link.parent, count) unless link.parent.nil?
  end

end