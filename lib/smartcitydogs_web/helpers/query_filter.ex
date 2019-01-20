defmodule SmartcitydogsWeb.QueryFilter do
  import Ecto.Query

  def filter(query, params) do
    Enum.reduce(params, query, fn {column, value}, query ->
      case sanitize(value) do
        value when is_list(value) and value != [] ->
          where(query, [s], field(s, ^String.to_atom(column)) in ^value)

        value when is_binary(value) and value != "" ->
          where(query, [s], field(s, ^String.to_atom(column)) == ^value)

        _ ->
          query
      end
    end)
  end

  def sanitize(value) when is_list(value) do
    value |> Enum.filter(&(String.length(&1) > 0))
  end

  def sanitize(value) when is_binary(value) do
    value |> String.trim()
  end
end
