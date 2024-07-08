defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "start_link/1 - default state" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.current_state(pid) == []

    {:ok, pid} = Stack.start_link([name: :process_name, state: [1]])
    assert Stack.current_state(pid) == [1]
  end

  test "start_link/1 - default configuration" do
    {:ok, pid} = Stack.start_link([])
    assert Process.whereis(Stack) == pid

    {:ok, pid} = Stack.start_link([name: :process_name])
    assert Process.whereis(:process_name) == pid
  end

  test "pop/1 - remove one element from stack" do
    {:ok, pid} = Stack.start_link([state: [1, 2, 3]])
    assert Stack.pop(pid) == 1
    assert Stack.current_state(pid) == [2, 3]
  end

  test "pop/1 - remove multiple elements from stack" do
    {:ok, pid} = Stack.start_link([state: [1, 2, 3]])
    assert Stack.pop(pid) == 1
    assert Stack.pop(pid) == 2
    assert Stack.pop(pid) == 3
    assert Stack.current_state(pid) == []
  end

  test "pop/1 - remove element from empty stack" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.pop(pid) == nil
    assert Stack.current_state(pid) == []
  end

  test "push/2 - add element to empty stack" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.push(pid, 1) == :ok
    assert Stack.current_state(pid) == [1]
  end

  test "push/2 - add element to stack with multiple elements" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.push(pid, 4) == :ok
    assert Stack.push(pid, 3) == :ok
    assert Stack.push(pid, 2) == :ok
    assert Stack.push(pid, 1) == :ok
    assert Stack.current_state(pid) == [1, 2, 3, 4]
  end
end
