defmodule SmartcitydogsWeb.Encoder do
  def struct_to_map(list) when is_list(list) do
    list
    |> Enum.map(&sanitize_recursive(&1))
  end

  def struct_to_map(map) when is_map(map) do
    sanitize_recursive(map)
  end

  defp sanitize_recursive(map) do
    map
    |> Map.from_struct()
    |> Map.drop([:__meta__, :__cardinality__, :__field__, :__owner__, :password])
    |> Enum.map(fn
      {key, %DateTime{} = value} when is_map(value) -> {key, DateTime.to_string(value)}
      {key, value} when is_map(value) -> {key, sanitize_recursive(value)}
      {key, value} when is_list(value) -> {key, struct_to_map(value)}
      x -> x
    end)
    |> Map.new()
  end
end
