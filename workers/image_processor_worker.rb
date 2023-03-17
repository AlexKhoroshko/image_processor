require_relative '../modules/text_recognition'
require 'sneakers'
require 'sneakers/worker'

class ImageProcessorWorker
  include Sneakers::Worker
  from_queue 'image-processor',
             exchange: '',
             exchange_type: :direct,
             routing_key: 'image-processor',
             durable: true

  def work(message)
    url = JSON.parse(message, symbolize_names: true)
    result = TextRecognition.recognize_text(url)
    puts "OCR result: #{result}"
    ack!
  rescue StandardError => e
    reject!
  end
end
