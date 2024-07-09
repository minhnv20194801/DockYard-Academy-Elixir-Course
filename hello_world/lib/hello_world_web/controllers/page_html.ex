defmodule HelloWorldWeb.PageHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use HelloWorldWeb, :html

  def home(assigns) do
    ~H"""
    Hello World
    """
  end
end
