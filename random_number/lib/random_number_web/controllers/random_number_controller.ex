defmodule RandomNumberWeb.RandomNumberController do
  use RandomNumberWeb, :controller

  def random_number(conn, _params) do
    render(conn, :random_number)
  end
end
