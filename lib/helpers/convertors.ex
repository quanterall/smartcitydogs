defmodule Smartcitydogs.Converter do
  def to_keyword_list(map) do
    Enum.map(map, fn {k, v} ->
      v =
        cond do
          is_map(v) -> to_keyword_list(v)
          true -> v
        end

      {String.to_atom("#{k}"), v}
    end)
  end
end
