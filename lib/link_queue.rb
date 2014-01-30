class LinkQueue
  attr_reader :depth_limit, :link_limit

  def initialize(depth_limit, link_limit)
    @queue = Queue.new
    @enqueue_count = 0
    @depth_limit = depth_limit
    @link_limit = link_limit
  end

  def has_elements?
    ! count.zero?
  end

  def enqueue link
    @enqueue_count = @enqueue_count.next
    @queue << link unless link.depth > depth_limit or @enqueue_count > link_limit
  end

  def count
    @queue.length
  end

  def dequeue
    @queue.pop
  end
end