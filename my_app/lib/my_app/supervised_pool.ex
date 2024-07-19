defmodule MyApp.SupervisedPool do
  use Supervisor

  def start_link(opts) do
    name = Keyword.get(opts, :name, __MODULE__)
    # we've made our name configurable for demonstration purposes.
    Supervisor.start_link(__MODULE__, opts, name: name)
  end

  @impl true
  def init(opts) do
    size = Keyword.get(opts, :size, System.schedulers_online())
    # System.schedulers_online() returns the number of
    # available schedulers on the current machine.
    child_specs =
      Enum.map(1..size, fn n ->
        %{
          id: :"supervised_worker_#{n}",
          start: {Worker, :start_link, [[registry: SupervisedPool.Registry]]}
        }
      end)

    children =
      [
        {Registry, name: SupervisedPool.Registry, keys: :duplicate}
      ] ++ child_specs

    Supervisor.init(children, strategy: :one_for_one)
  end
end
