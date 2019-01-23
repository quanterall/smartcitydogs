defmodule SmartcitydogsWeb.AnimalController do
  use SmartcitydogsWeb, :controller

  alias Smartcitydogs.Animal
  alias Smartcitydogs.Repo
  import Ecto.Query
  alias SmartcitydogsWeb.QueryFilter

  ## Render for regular users
  def index(conn, params) do
    query =
      Animal
      |> preload(:animal_status)
      |> order_by(desc: :inserted_at)
      |> prepare_query_filters(params)

    page = Repo.paginate(query, params)

    render(
      conn,
      "index.html",
      animals: page.entries,
      page: page
    )
  end

  defp prepare_query_filters(query, %{"animal_filter" => params}) do
    QueryFilter.filter(query, params)
  end

  defp prepare_query_filters(query, %{}) do
    query
  end

  def show(conn, %{"id" => id}) do
    animal =
      Repo.get(Animal, id)
      |> Repo.preload([:animal_images, :animal_status])

    render(conn, "show.html", animal: animal)
  end
end
