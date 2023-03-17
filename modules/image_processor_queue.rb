require 'bunny'

module ImageProcessorQueue
  class << self
    def publish(payload)
      queue.publish(payload.to_json, persistent: true)
    end

    private

    def queue
      @queue ||= channel.queue('image-processor', durable: true)
    end

    def channel
      @channel ||= connection.create_channel
    end

    def connection
      @connection ||= create_connection
    end

    def create_connection
      bunny = Bunny.new(hostname: 'rabbitmq', username: 'guest', password: 'guest')
      bunny.start
      bunny
    end
  end
end
