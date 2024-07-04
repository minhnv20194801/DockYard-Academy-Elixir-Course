defmodule ModuleB do
  def run do
    ModuleA.run() <> "B"
  end
end
