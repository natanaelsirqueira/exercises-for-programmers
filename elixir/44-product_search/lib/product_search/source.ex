defprotocol ProductSearch.Source do
  @moduledoc """
  Protocol that represents a products JSON source.

  ## Implementations

    - `ProductSearch.Source.File` - Reads and stores the JSON using a file.
    - `ProductSearch.Source.Memory` - Reads and stores the JSON using an Agent.
  """

  @spec read(t) :: String.t
  def read(source)

  @spec save(t, String.t) :: no_return
  def save(source, content)
end
