defmodule SmartcitydogsWeb.SignalController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Signal
  alias Smartcitydogs.Converter

  def index(conn, params) do
    filters = Map.get(params, "filters", %{})
    page = Signal.paginate_preloaded(params, filters)
    keyword_params = params |> Map.delete("page") |> Converter.to_keyword_list()

    render(conn, "index.html", page: page, params: keyword_params)
  end

  def show(conn, %{"id" => id}) do
    signal = Signal.get_preloaded(id)

    {:ok, signal} = Signal.update(signal, %{"view_count" => signal.view_count + 1})
    render(conn, "show.html", signal: signal)
  end
end
