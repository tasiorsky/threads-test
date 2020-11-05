class ThreadsController < ApplicationController
  def index
    ThreadsTest::Application.config.test_value ||= rand(100)

    @val = ThreadsTest::Application.config.test_value

    respond_to :html
  end

  def set
    ThreadsTest::Application.config.test_value = rand(100)
    redirect_to threads_path
  end

  def get
    values = []

    loop do
      value = ThreadsTest::Application.config.test_value
      break if value == -1
      next if value.in?(values)

      values << value
      ActionCable.server.broadcast('main_channel',
                                   thread: Thread.current.object_id,
                                   values_in_thread: values)
    end

    head :ok
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

  private

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
