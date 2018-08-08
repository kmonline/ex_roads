defmodule GoogleRoads.RequestTest do
  use ExUnit.Case, async: false
  alias GoogleRoads.Request, as: Request

  defmodule MockRequest do
    def get(url, headers, options) do
      {:ok, %{body: url, headers: headers, options: options}}
    end
  end

  setup do
    requester = Application.get_env(:google_roads, :requester)
    Application.put_env(:google_roads, :requester, MockRequest)

    on_exit fn ->
      Application.put_env(:google_roads, :requester, requester)
    end

    :ok
  end

  test "construct full URL from endpoint" do
    {:ok, %{body: url}} = Request.get("foobar", [])

    assert %{
      scheme: "https",
      authority: "roads.googleapis.com",
      path: "/v1/foobar"
    } = URI.parse(url)
  end

  test "convert params to query" do
    params = [key: "key", foo: "param1", bar: "param2"]

    {:ok, %{body: url}} = Request.get("foobar", params)

    assert %{query: "key=key&foo=param1&bar=param2"} = URI.parse(url)
  end

  test "supports headers" do
    params = [headers: [{"Accept-Language", "pt-BR"}]]

    {:ok, %{headers: headers}} = Request.get("foobar", params)

    assert headers === params[:headers]
  end
end
