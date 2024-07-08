defmodule Stack do
  @moduledoc """
  iex> {:ok, pid} = Stack.start_link([])
  iex> :ok = Stack.push(pid, 1)
  iex> Stack.pop(pid)
  1
  iex> Stack.pop(pid)
  nil
  """
  use GenServer

  def start_link(opts) do
    name = Keyword.get(opts, :name, __MODULE__)
    initial_state = Keyword.get(opts, :state, [])
    GenServer.start_link(__MODULE__, initial_state, [name: name])
  end

  @doc """
  iex> {:ok, pid} = Stack.start_link([])
  iex> :ok = Stack.push(pid, 1)
  iex> Stack.pop(pid)
  1
  iex> Stack.pop(pid)
  nil
  """
  def push(stack_pid, element) do
    GenServer.cast(stack_pid, {:push, element})
  end

  @doc """
  iex> {:ok, pid} = Stack.start_link([])
  iex> Stack.pop(pid)
  nil
  """
  def pop(stack_pid) do
    GenServer.call(stack_pid, :pop)
  end

  def current_state(stack_pid) do
    GenServer.call(stack_pid, :current_state)
  end

  # Define the necessary Server callback functions:
  def init(opts) do
    {:ok, opts}
  end

  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end

  def handle_call(:pop, _from, state) do
    case state do
      [] ->
        {:reply, nil, state}

      _ ->
        [head | tail] = state
        {:reply, head, tail}
    end
  end

  def handle_call(:current_state, _from, state) do
    {:reply, state, state}
  end
end
