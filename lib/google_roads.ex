defmodule GoogleRoads do
  @moduledoc """
  Provides methods to interact with Google Roads API.

  Unless otherwise noted, all the functions take the required Google
  parameters as its own  parameters, and all optional ones in an
  `options` keyword list.

  The `options` keyword can also take special entry for `headers` and
  `options`, which are passed to the underlying `Request`. See the
  documentation of `HTTPoison` for details.
  """

  alias GoogleRoads.{Request, Response}

  @type latitude :: number
  @type longitude :: number
  @typedoc """
  A latitude/longitude pair in tuple or comma-separated string format.
  """
  @type coordinate :: {latitude(), longitude()} | String.t
  @typedoc """
  A tagged tuple with an ID of a known place.
  """
  @type path :: coordinate()

  @type options :: keyword()

  @type interpolate :: boolean

  @doc """
  Takes up to 100 GPS points collected along a route, and returns a similar set of data, with the points snapped to the most likely roads the vehicle was traveling along

  Args:
    * `path` — The path to be snapped. The path parameter accepts a
      list of latitude/longitude pairs. Latitude and longitude values
      should be separated by commas. Coordinates should be separated by
      the pipe character: "|".

      For example: path=60.170880,24.942795|60.170879,24.942796|60.170877,24.942796.

  Options:
    * `interpolate` — Whether to interpolate a path to include all points forming the full road-geometry. When true, additional interpolated points will also be returned, resulting in a path that smoothly follows the geometry of the road, even around corners and through tunnels. Interpolated paths will most likely contain more points than the original path. Defaults to `false`.

  This function returns `{:ok, body}` if the request is successful, and
  Google returns data. It returns `{:error, error}` when there is HTTP
  errors, or `{:error, status, error_message}` when the request is successful, but
  Google returns status codes different than "OK".

  ## Examples

      # Snap to Roads with an invalid API key
      iex> {:error, status, error_message} = GoogleRoads.snap_to_roads("-35.27801,149.12958|-35.28032,149.12907|-35.28099,149.12929", true, [
      ...> key: "invalid key"
      ...> ])
      iex> status
      "INVALID_ARGUMENT"
      iex> error_message
      "The provided API key is invalid."

      iex> {:ok, result} = GoogleRoads.snap_to_roads("-35.27801,149.12958|-35.28032,149.12907|-35.28099,149.12929", true)
      iex> match?(%{"snappedPoints" => _}, result)
      true
      iex> is_list(result["snappedPoints"])
      true
      iex> Enum.count(result["snappedPoints"])
      26
  """
  @spec snap_to_roads(path(), interpolate(), options()) :: Response.t()
  def snap_to_roads(path, interpolate \\ false, options \\ []) do
    params = options
    |> Keyword.merge([
      path: path,
      interpolate: interpolate
    ])

    GoogleRoads.get("snapToRoads", params)
  end

  @doc """
  Direct request to Google Roads API endpoint.

  Instead of relying on the functionality this module provides, you can
  use this function to make direct request to the Google Roads API.

  It takes an endpoint string, and a keyword list of parameters.

  ## Examples

      iex> {:error, status, error_message} = GoogleRoads.get("snapToRoads", [
      ...>   path: "-35.27801,149.12958|-35.28032,149.12907|-35.28099,149.12929",
      ...>   interpolate: true,
      ...>   key: "invalid key",
      ...> ])
      iex> status
      "INVALID_ARGUMENT"
      iex> error_message
      "The provided API key is invalid."

      iex> {:ok, result} = GoogleRoads.get("snapToRoads", [
      ...>   path: "-35.27801,149.12958|-35.28032,149.12907|-35.28099,149.12929",
      ...>   interpolate: true,
      ...> ])
      iex> match?(%{"snappedPoints" => _}, result)
      true

      iex> {:error, reason} = GoogleRoads.get("snapToRoads", [
      ...>   path: "-35.27801,149.12958|-35.28032,149.12907|-35.28099,149.12929",
      ...>   interpolate: true,
      ...>   headers: [{"Accept-Language", "pt-BR"}],
      ...>   options: [timeout: 0]
      ...> ])
      ...> reason
      :connect_timeout
  """
  @spec get(String.t, keyword()) :: Response.t()
  def get(endpoint, params) do
    Request.get(endpoint, params)
    |> Response.wrap
  end
end
