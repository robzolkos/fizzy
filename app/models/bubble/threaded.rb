module Bubble::Threaded
  def thread
    Bubble::Thread.new self
  end
end
