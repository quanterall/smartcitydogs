defmodule SmartcitydogsWeb.PageController do
  use SmartcitydogsWeb, :controller

  import Ecto.Query
  alias Smartcitydogs.DataSignals
  alias Smartcitydogs.DataPages
  alias Smartcitydogs.DataAnimals
  alias Smartcitydogs.Animals
  alias Smartcitydogs.Signals
  alias Smartcitydogs.News
  alias Smartcitydogs.Repo

  def index(conn, _params) do
    signal =
      Signals
      |> limit(6)
      |> Repo.all()
      |> Repo.preload([:signals_types, :signals_categories, :signals_comments])

    news =
      News
      |> limit(4)
      |> Repo.all()

    animal =
      Animals
      |> limit(6)
      |> Repo.all()
      |> Repo.preload([:animals_image, :animals_status])

    adopted_animals =
      Repo.all(from(p in Animals, where: p.animals_status_id == 3))
      |> Smartcitydogs.Repo.preload(:animals_status)
      |> Repo.preload([:animals_image, :animals_status])

    render(conn, "index.html",
      signal: signal,
      news: news,
      animals: animal,
      adopted_animals: adopted_animals
    )
  end
end
