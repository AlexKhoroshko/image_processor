require_relative '../../modules/text_recognition'
require_relative '../../workers/image_processor_worker'

RSpec.describe ImageProcessorWorker do
  let(:message) { { url: 'http://example.com/image.jpg' }.to_json }
  let(:result_text) { 'Hello, World!' }

  before do
    allow(TextRecognition).to receive(:recognize_text).and_return(result_text)
  end

  describe '#work' do
    it 'calls TextRecognition.recognize_text with the URL in the message' do
      expect(TextRecognition).to receive(:recognize_text).with({ url: 'http://example.com/image.jpg' })
      worker = ImageProcessorWorker.new
      worker.work(message)
    end

    it 'logs the OCR result' do
      expect do
        worker = ImageProcessorWorker.new
        worker.work(message)
      end.to output(/OCR result: #{result_text}/).to_stdout
    end

    it 'acks the message' do
      worker = ImageProcessorWorker.new
      expect(worker).to receive(:ack!)
      worker.work(message)
    end

    context 'when an error occurs' do
      before do
        allow(TextRecognition).to receive(:recognize_text).and_raise(StandardError)
      end

      it 'rejects the message' do
        worker = ImageProcessorWorker.new
        expect(worker).to receive(:reject!)
        worker.work(message)
      end
    end
  end
end
