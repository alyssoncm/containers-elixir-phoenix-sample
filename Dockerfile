
# Use an official Elixir runtime as a parent image
FROM elixir:1.12.3

# Set the working directory inside the container
WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Update package lists and install curl
RUN apt-get update && apt-get install -y curl

# Install Node.js and NPM
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && apt-get install -y nodejs

# the application code into the container
COPY . .

# Install the application dependencies
RUN mix deps.get

# Compile the application code
RUN mix compile

# Install and build the assets
RUN cd assets && \
    npm install && \
    node node_modules/webpack/bin/webpack.js --mode production

# Start the Phoenix app
CMD ["mix", "phx.server"]
