require 'rtesseract'
require 'mini_magick'

module TextRecognition
  class << self
    def recognize_text(image_path)
      image = MiniMagick::Image.open(image_path)
      image.format 'png'

      result = RTesseract.new(image.path).to_s
      result.strip
    end
  end
end
