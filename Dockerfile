FROM ruby:3.1.1

WORKDIR /app

ENV RAILS_ENV=production
ENV TZ=Asia/Tokyo
ENV RAILS_LOG_TO_STDOUT=true

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install -j4
COPY . /app

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "8080"]
