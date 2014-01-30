class Link
  attr_reader :url, :parent

  def initialize(url, parent)
    @parent = parent
    @url = url
  end

  def == other
    self.class == other.class &&
        self.url == other.url &&
        self.parent == other.parent
  end

  def depth
    return 1 if parent.nil?
    parent.depth.next
  end
end