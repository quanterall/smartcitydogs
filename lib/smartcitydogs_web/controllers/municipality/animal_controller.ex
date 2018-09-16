defmodule SmartcitydogsWeb.Municipality.AnimalController do
  use SmartcitydogsWeb, :controller
  alias Smartcitydogs.{Animals, Repo, AnimalsFilters}
  import Ecto.Query
  alias Smartcitydogs.PerformedProcedures

  def index(conn, params) do
    page =
      Animals
      |> order_by(desc: :inserted_at)
      |> preload([:animals_status])

    page =
      if params["animals_filters"]["animals_status_id"] &&
           params["animals_filters"]["animals_status_id"] != "" do
        page
        |> where(
          [animal],
          animal.animals_status_id == ^params["animals_filters"]["animals_status_id"]
        )
      else
        page
      end

    page =
      if params["animals_filters"]["adopted"] == "true" do
        page
        |> join(:inner, [animal], c in assoc(animal, :adopt))
      else
        page
      end

    filter_changeset =
      if params["animals_filters"] != nil do
        AnimalsFilters.changeset(%AnimalsFilters{}, params["animals_filters"])
      else
        AnimalsFilters.changeset(%AnimalsFilters{}, %{})
      end

    pagination_params = [
      {
        :animals_filters,
        [
          {:animals_status_id, params["animals_filters"]["animals_status_id"]},
          {:adopted, params["animals_filters"]["adopted"]}
        ]
      }
    ]

    page = Repo.paginate(page, params)

    render(
      conn,
      "index.html",
      filter_changeset: filter_changeset,
      page: page,
      animals: page.entries,
      pagination_params: pagination_params
    )
  end
end
