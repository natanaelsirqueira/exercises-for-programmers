defmodule ProductSearch.Source.Memory do
  @moduledoc """
  Contains the read/save operations for the JSON data using an Agent for storage.
  """

  defstruct [:agent_pid]

  @doc """
  Creates an Agent to store the JSON content.
  """
  def new(content) do
    {:ok, pid} = Agent.start_link(fn -> content end)

    %__MODULE__{agent_pid: pid}
  end

  defimpl ProductSearch.Source do
    def read(source) do
      Agent.get(source.agent_pid, & &1)
    end

    def save(source, content) do
      Agent.update(source.agent_pid, fn _ -> content end)
    end
  end
end
