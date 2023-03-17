require 'rack'
require 'json'
require_relative 'modules/image_processor_queue'

class ImageProcessorApp
  def call(env)
    if env['REQUEST_METHOD'] == 'POST' && env['PATH_INFO'] == '/process_image'
      request = Rack::Request.new(env)
      request_body = request.body.read
      payload = JSON.parse(request_body)
      image_url = payload['fileUrl']
      ImageProcessorQueue.publish(image_url)
      [200, { 'Content-Type' => 'text/plain' }, ['Message sent to queue']]
    else
      [404, { 'Content-Type' => 'text/plain' }, ['Not found']]
    end
  end
end
