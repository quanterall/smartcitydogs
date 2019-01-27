defmodule SmartcitydogsWeb.AnimalController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Animal
  alias Smartcitydogs.Convertor

  def index(conn, params) do
    filters = Map.get(params, "animal_filter", %{})
    page = Animal.paginate_preloaded(params, filters)
    keyword_params = params |> Map.delete("page") |> Convertor.to_keyword_list()

    render(conn, "index.html", page: page, params: keyword_params)
  end

  def show(conn, %{"id" => id}) do
    animal = Animal.get_preloaded(id)
    render(conn, "show.html", animal: animal)
  end
end
