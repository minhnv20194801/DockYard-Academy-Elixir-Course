defmodule RubixCube.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Protocol

  Protocol.derive(Jason.Encoder, RubixCube.RubixCube)

  @impl true
  def start(_type, _args) do
    {success?, json} = File.read("rubix_save_state")

    rubix =
      if success? == :ok do
        {_ok, rubix} = Jason.decode(json, keys: :atoms)
        struct(RubixCube.RubixCube, rubix)
      else
        nil
      end

    children = [
      # Starts a worker by calling: RubixCube.Worker.start_link(arg)
      # {RubixCube.Worker, arg}
      {RubixCube.RubixCube, [state: rubix]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RubixCube.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
