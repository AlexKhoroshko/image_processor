FROM ruby:3.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        rabbitmq-server  \
        libpq-dev \
        tesseract-ocr \
        tesseract-ocr-eng \
        tesseract-ocr-rus \
        imagemagick

RUN mkdir /app
WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE 4567
EXPOSE 9292
EXPOSE 5672
EXPOSE 15672

CMD ["rackup", "config.ru", "-p", "9292", "-s", "thin", "-o", "0.0.0.0"]