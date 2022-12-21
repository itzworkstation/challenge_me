FROM ruby:3.1.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client
RUN mkdir /myapp
WORKDIR /myapp
COPY . /myapp
RUN bundle install
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["bash"]