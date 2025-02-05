import Config

config :tailwind,
  version: "3.4.3",
  weather: [
    args: ~w(
      --minify
      --config=tailwind.config.js
      --input=index.css
      --output=../priv/static/assets/index.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

config :esbuild,
  version: "0.24.2",
  weather: [
    args: ~w(index.js --minify --bundle --target=es2017 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__)
  ]
