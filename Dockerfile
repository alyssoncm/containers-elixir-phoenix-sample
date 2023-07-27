
# Use an official Elixir runtime as a parent image
FROM elixir:1.12.3

# Set the working directory inside the container
WORKDIR /app

# Install hex and rebar
RUN mix local.hex --force && \
    mix local.rebar --force

# Install Node.js and NPM
RUN apt-get update && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && apt-get install -y nodejs
# Fixed the error by adding 'apt-get update' to update package lists first before installing curl,
# and also combined the commands to install Node.js and NPM into a single RUN command.
# Additionally, downloaded the 'nodesource_setup.sh' script and ran it using bash.

 Copy# the application code into the container
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
