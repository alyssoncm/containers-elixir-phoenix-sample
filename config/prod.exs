use Mix.Config

config :my_app, MyAppWeb.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [scheme: "http", host: "localhost", port: {:system, "PORT"}],
  cache_static_manifest: "priv/static/cache_manifest.json"

config :my_app, MyAppWeb.Endpoint, server: true
