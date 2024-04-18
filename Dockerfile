# Use the official Ruby image
FROM ruby:3.0.0

# Set environment variables
ENV RAILS_ROOT /app
ENV RAILS_ENV production

# Set working directory
WORKDIR $RAILS_ROOT

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y nodejs

# Install latest version of Bundler
RUN gem install bundler

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install --jobs 20 --retry 5

# Copy the rest of the application code
COPY . .

# Expose port 3000
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
