# GoogleRoads

Elixir wrapper for Google Roads API based in [sntran/ex_maps](https://github.com/sntran/ex_maps)

[![Build Status](https://img.shields.io/travis/kmonline/ex_roads/master.svg)](https://travis-ci.org/kmonline/ex_roads)
[![Hex Version](https://img.shields.io/hexpm/v/google_roads.svg)](https://hex.pm/packages/google_roads)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

- [x] [Snap to roads](https://developers.google.com/maps/documentation/roads/snap) - Best-fit road geometry for a given set of GPS coordinates
- [ ] [Nearest roads](https://developers.google.com/maps/documentation/roads/nearest) - Closest road segment for a given set of GPS coordinates
- [ ] [Speed limits](https://developers.google.com/maps/documentation/roads/speed-limits) - Posted speed limit for a given road segment

## Methods

- `snap_to_roads/3`
- `get/2`

## Development

You'll need a [Google API key](https://console.developers.google.com) with
all relevant APIs (see above) enabled. Add your key to the environment as specified above.

Then run tests:

`mix deps.get test`

`mix test`

### Setup credentials

In your `config/config.exs`:

```elixir
config :google_roads,
  api_key: "your_api_key"
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_roads` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_roads, "~> 0.0.1"}
  ]
end
```
