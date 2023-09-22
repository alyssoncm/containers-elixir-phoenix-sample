FROM elixir:1.12.3

WORKDIR /app

RUN mix local.hex --force && \
    mix local.rebar --force

RUN apt-get update && apt-get install -y curl \
    && curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && apt-get install -y nodejs

COPY . .

RUN mix deps.get

RUN mix compile

RUN cd assets && \
    npm install && \
    node node_modules/webpack/bin/webpack.js --mode production

CMD ["mix", "phx.server"]