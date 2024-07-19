defmodule MyApp.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    poolboy_config = [
      name: {:local, :worker},
      worker_module: Worker,
      size: 4
    ]

    children = [
      # Starts a worker by calling: MyApp.Worker.start_link(arg)
      # {MyApp.Worker, arg}
      :poolboy.child_spec(:worker, poolboy_config)
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MyApp.Supervisor]
    Supervisor.start_link(children, opts)

    # MyApp.SupervisedPool.start_link(name: :example_pool, size: 4)
  end
end
