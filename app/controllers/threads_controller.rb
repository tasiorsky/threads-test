class ThreadsController < ApplicationController
  def index
    respond_to :html
  end

  def go
    @x = 0
    init_threads

    7.times do
      @x = rand(100)

      sleep(2)
    end

    @x = -1

    head :ok
  end

  def init_threads
    threads = []

    3.times do
      t = Thread.new do
        values = []

        loop do
          break if @x == -1
          next if @x.in?(values)

          values << @x
          ActionCable.server.broadcast('main_channel',
                                       thread: Thread.current.object_id,
                                       values_in_thread: values)
        end
      end

      threads << t
    end

    threads.join
  end
end
