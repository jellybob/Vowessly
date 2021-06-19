FROM ruby:1.9

COPY . /app
WORKDIR /app

RUN bundle install --without=cucumber --without=test

CMD unicorn -p 3000