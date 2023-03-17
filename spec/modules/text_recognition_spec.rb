require_relative '../../modules/text_recognition'
require 'rtesseract'
require 'mini_magick'

RSpec.describe TextRecognition do
  let(:image_path) { 'spec/fixtures/sample.jpg' }
  let(:result_text) { 'Hello, World!' }

  before do
    allow_any_instance_of(MiniMagick::Image).to receive(:path).and_return(image_path)
    allow_any_instance_of(RTesseract).to receive(:to_s).and_return(result_text)
  end

  describe '.recognize_text' do
    it 'returns the text from the image' do
      expect(TextRecognition.recognize_text(image_path)).to eq(result_text.strip)
    end

    it 'formats the image as png and then recognizes the text' do
      expect_any_instance_of(MiniMagick::Image).to receive(:format).with('png')
      expect_any_instance_of(RTesseract).to receive(:to_s).and_return('Hello, World!')

      TextRecognition.recognize_text(image_path)
    end
  end
end
