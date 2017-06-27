FROM ruby:1.9.3

ENV RAILS_ROOT /vis

RUN mkdir $RAILS_ROOT

WORKDIR $RAILS_ROOT

RUN apt-get update

COPY Gemfile $RAILS_ROOT

COPY Gemfile.lock $RAILS_ROOT

RUN bundle install

COPY . $RAILS_ROOT

EXPOSE 4002

CMD puma -C config/puma.rb
