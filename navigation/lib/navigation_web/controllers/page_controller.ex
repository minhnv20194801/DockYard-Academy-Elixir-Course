defmodule NavigationWeb.PageController do
  use NavigationWeb, :controller

  def home(conn, _params) do
    render(conn, :home, layout: false)
  end

  def about(conn, _params) do
    render(conn, :about, layout: false)
  end

  def projects(conn, _params) do
    render(conn, :projects, layout: false)
  end
end
