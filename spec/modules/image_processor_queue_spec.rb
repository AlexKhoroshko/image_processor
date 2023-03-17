require 'json'
require_relative '../../modules/image_processor_queue'

RSpec.describe ImageProcessorQueue do
  let(:queue) { instance_double(Bunny::Queue) }
  let(:channel) { instance_double(Bunny::Channel) }
  let(:connection) { instance_double(Bunny::Session) }

  before do
    allow(Bunny).to receive(:new).and_return(connection)
    allow(connection).to receive(:start)
    allow(connection).to receive(:create_channel).and_return(channel)
    allow(channel).to receive(:queue).and_return(queue)
  end

  describe '.publish' do
    let(:payload) { { key: 'value' } }

    it 'publishes the payload to the queue' do
      expect(queue).to receive(:publish).with(payload.to_json, persistent: true)
      ImageProcessorQueue.publish(payload)
    end

    it 'raises an error if payload is not provided' do
      expect { ImageProcessorQueue.publish }.to raise_error(
        ArgumentError, 'wrong number of arguments (given 0, expected 1)'
      )
    end
  end
end
