class ThreadsController < ApplicationController
  def index
    respond_to :html
  end

  def go
    @x = 0
    threads(3).join

    10.times do
      @x = rand(100)

      sleep(2)
    end

    @x = -1
  end

  def threads(count)
    threads = []

    count.times do
      t = Thread.new do
        current_value = @x

        loop do
          break if @x == -1

          next if current_value == @x

          ActionCable.server.broadcast('main_channel', {
            thread: Thread.current.object_id,
            value_in_thread: @x
          })
          current_value = @x
        end
      end

      threads << t
    end

    threads
  end
end





# def test
#   x = 'a'

#   10.times { x << 'a' }

#   t1 = Thread.new do
#     10.times { x << 'b' }
#     p "first - #{x}"
#   end
#   t2 = Thread.new do
#     10.times { x << 'c' }
#     p "second - #{x}"
#   end

#   p "base #{x}"
# end
