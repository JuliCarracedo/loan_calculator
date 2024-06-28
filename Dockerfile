# Base image
FROM ruby:3.1.1

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs yarn sqlite3

# Set the working directory
WORKDIR /app

# Copy the Gemfile and Gemfile.lock
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Install the gems
RUN bundle install

# Copy the application code
COPY . /app

# Precompile assets
RUN bundle exec rake assets:precompile

# Expose port 3009
EXPOSE 3009

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
