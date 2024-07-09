defmodule CounterWeb.PageController do
  use CounterWeb, :controller

  def home(conn, params) do
    # The home page is often custom made,
    # so skip the default app layout.
    count = params["count"] || 0
    render(conn, :home, count: count)
  end

  def increase_by(conn, params) do
    # The home page is often custom made,
    # so skip the default app layout.
    IO.inspect(params)
    count = String.to_integer(params["count"])
    increase_value = String.to_integer(params["increment_by"])
    render(conn, :home, count: count + increase_value)
  end
end
