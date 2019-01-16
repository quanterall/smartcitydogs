defmodule SmartcitydogsWeb.Encoder do
  def encode(list) do
    list
    |> Enum.map(&sanitize_recursive(&1))
  end

  defp sanitize_recursive(map) do
    sanitized =
      map
      |> Map.from_struct()
      |> Map.drop([:__meta__, :__cardinality__, :__field__, :__owner__, :password])
      |> Enum.map(fn
        {key, %DateTime{} = value} when is_map(value) -> {key, DateTime.to_string(value)}
        {key, value} when is_map(value) -> {key, sanitize_recursive(value)}
        {key, value} when is_list(value) -> {key, encode(value)}
        {key, value} when is_number(value) -> {key, value}
        x -> x
      end)
      |> Map.new()
  end
end
